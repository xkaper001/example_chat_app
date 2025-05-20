import '../entities/group_chat.dart';

abstract class GroupChatRepository {
  Future<List<GroupChat>> getGroupChats();
  Future<GroupChat> getGroupChatById(String id);
}
