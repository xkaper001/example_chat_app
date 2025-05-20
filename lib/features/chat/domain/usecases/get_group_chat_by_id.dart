import '../entities/group_chat.dart';
import '../repositories/group_chat_repository.dart';

class GetGroupChatById {
  final GroupChatRepository repository;

  GetGroupChatById(this.repository);

  Future<GroupChat> call(String id) async {
    return await repository.getGroupChatById(id);
  }
}
