import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/group_chat.dart';
import '../../domain/usecases/get_group_chat_by_id.dart';
import '../../domain/usecases/get_group_chats.dart';

// Events
abstract class GroupChatEvent extends Equatable {
  const GroupChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadGroupChats extends GroupChatEvent {
  const LoadGroupChats();
}

class LoadGroupChatDetails extends GroupChatEvent {
  final String groupId;
  const LoadGroupChatDetails(this.groupId);

  @override
  List<Object?> get props => [groupId];
}

// States
abstract class GroupChatState extends Equatable {
  const GroupChatState();

  @override
  List<Object?> get props => [];
}

class GroupChatInitial extends GroupChatState {}

class GroupChatsLoading extends GroupChatState {}

class GroupChatsLoaded extends GroupChatState {
  final List<GroupChat> groupChats;
  const GroupChatsLoaded(this.groupChats);

  @override
  List<Object?> get props => [groupChats];
}

class GroupChatDetailsLoaded extends GroupChatState {
  final GroupChat groupChat;
  const GroupChatDetailsLoaded(this.groupChat);

  @override
  List<Object?> get props => [groupChat];
}

class GroupChatError extends GroupChatState {
  final String message;
  const GroupChatError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  final GetGroupChats getGroupChats;
  final GetGroupChatById getGroupChatById;

  GroupChatBloc({
    required this.getGroupChats,
    required this.getGroupChatById,
  }) : super(GroupChatInitial()) {
    on<LoadGroupChats>(_onLoadGroupChats);
    on<LoadGroupChatDetails>(_onLoadGroupChatDetails);
  }

  Future<void> _onLoadGroupChats(
    LoadGroupChats event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(GroupChatsLoading());
    try {
      final groupChats = await getGroupChats();
      emit(GroupChatsLoaded(groupChats));
    } catch (e) {
      emit(GroupChatError('Failed to load group chats: ${e.toString()}'));
    }
  }

  Future<void> _onLoadGroupChatDetails(
    LoadGroupChatDetails event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(GroupChatsLoading());
    try {
      final groupChat = await getGroupChatById(event.groupId);
      emit(GroupChatDetailsLoaded(groupChat));
    } catch (e) {
      emit(
          GroupChatError('Failed to load group chat details: ${e.toString()}'));
    }
  }
}
