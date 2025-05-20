import '../entities/group_chat.dart';
import '../repositories/group_chat_repository.dart';

class GetGroupChats {
  final GroupChatRepository repository;

  GetGroupChats(this.repository);

  Future<List<GroupChat>> call() async {
    return await repository.getGroupChats();
  }
}
