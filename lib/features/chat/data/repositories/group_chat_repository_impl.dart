import '../../domain/entities/group_chat.dart';
import '../../domain/repositories/group_chat_repository.dart';
import '../datasources/mock_chat_datasource.dart';

class GroupChatRepositoryImpl implements GroupChatRepository {
  final MockChatDataSource dataSource;

  GroupChatRepositoryImpl(this.dataSource);

  @override
  Future<List<GroupChat>> getGroupChats() async {
    return await dataSource.getGroupChats();
  }

  @override
  Future<GroupChat> getGroupChatById(String id) async {
    return await dataSource.getGroupChatById(id);
  }
}
