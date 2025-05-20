import 'package:equatable/equatable.dart';
import 'message.dart';

class GroupChat extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> participantIds;
  final List<Message> messages;
  final DateTime lastActivity;

  const GroupChat({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.participantIds,
    required this.messages,
    required this.lastActivity,
  });

  @override
  List<Object?> get props => [id, name, participantIds, lastActivity];
}
