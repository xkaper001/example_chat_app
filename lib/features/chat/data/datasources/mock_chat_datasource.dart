import '../../domain/entities/group_chat.dart';
import '../../domain/entities/message.dart';

class MockChatDataSource {
  // Current user ID to differentiate between sent and received messages
  final String currentUserId = 'user_4';
  // Generate mock group chat data
  Future<List<GroupChat>> getGroupChats() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      _createGroupChatWithHardcodedData(),
    ];
  }

  Future<GroupChat> getGroupChatById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final groups = await getGroupChats();
    return groups.firstWhere((group) => group.id == id,
        orElse: () => throw Exception('Group chat not found'));
  }

  // Creates a group chat with hardcoded data from the provided screenshot
  GroupChat _createGroupChatWithHardcodedData() {
    final DateTime today = DateTime(2025, 7, 10);
    final DateTime tomorrow = DateTime(2025, 7, 11);

    // Define user IDs
    final String tommyId = 'user_1'; // Current user
    final String louisanaId = 'user_2';
    final String cristoferId = 'user_3';
    final String me = 'user_4';

    // Create hardcoded messages based on the screenshot
    final List<Message> messages = [
      // First day messages
      Message(
        id: 'msg_1',
        content: 'Hi how are you? 😊',
        senderId: louisanaId,
        color: '0xFF2A9D8F',
        senderName: 'Lousiana',
        timestamp: DateTime(2025, 7, 10, 12, 55),
        isRead: true,
      ),
      Message(
        id: 'msg_2',
        content: 'Hi how are you?',
        senderId: louisanaId,
        color: '0xFF2A9D8F',
        senderName: 'Lousiana',
        timestamp: DateTime(2025, 7, 10, 12, 56),
        isRead: true,
      ),
      Message(
        id: 'msg_3',
        content:
            'Yes Im good, thanks for asking. Didn\'t do much, feeling bit sick after that meal. So just exhausted, watching netflux. 😢',
        senderId: tommyId,
        color: '0xFF1D4B45',
        senderName: 'Tommy',
        timestamp: DateTime(2025, 7, 10, 12, 57),
        isRead: true,
      ),
      Message(
        id: 'msg_4',
        content:
            'Yes, Im well. Had a long day, went hiking with the some people,it was extremely hot couldn\'t be b...',
        senderId: me,
        senderName: 'You',
        timestamp: DateTime(2025, 7, 10, 12, 58),
        isRead: true,
      ),
      Message(
        id: 'msg_5',
        content:
            'Yes Im good, thanks for asking. Didn\'t do much, feeling bit sick after that meal. So just exhausted, watching netflux',
        senderId: cristoferId,
        color: '0xFFF4392A',
        senderName: 'Cristofer',
        timestamp: DateTime(2025, 7, 10, 13, 20),
        isRead: true,
      ),
      Message(
        id: 'msg_6',
        content: 'Hi how are you?',
        senderId: louisanaId,
        color: '0xFF2A9D8F',
        senderName: 'Lousiana',
        timestamp: DateTime(2025, 7, 10, 13, 55),
        isRead: true,
      ),

      // Next day messages
      Message(
        id: 'msg_7',
        content:
            'Yes Im good, thanks for asking. Didn\'t do much, feeling bit sick after that meal. So just exhausted, watching netflix',
        senderId: tommyId,
        color: '0xFF1D4B45',
        senderName: 'Tommy',
        timestamp:
            DateTime(2025, 7, 11, 11, 20),
        isRead: true,
      ),
      Message(
        id: 'msg_8',
        content:
            'Yes Im good, thanks for asking. Didn\'t do much, feeling bit sick after that meal. So just exhausted, watching netflix',
        senderId: cristoferId,
        color: '0xFFF4392A',
        senderName: 'Cristofer',
        timestamp:
            DateTime(2025, 7, 11, 11, 23),
        isRead: true,
      ),
      Message(
        id: 'msg_9',
        content:
            'Yes, Im well. Had a long day, went hiking with the some people,it was extremely hot couldn\'t be b...',
        senderId: me,
        color: '0xFF1D4B45',
        senderName: 'You',
        timestamp:
            DateTime(2025, 7, 11, 12, 57),
        isRead: true,
      ),
      Message(
        id: 'msg_10',
        content: 'Hi how are you?',
        senderId: louisanaId,
        color: '0xFFAA7303',
        senderName: 'Lousiana',
        timestamp:
            DateTime(2025, 7, 11, 12, 59),
        isRead: true,
      ),
    ];

    // Sort messages by timestamp (newest first)
    messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return GroupChat(
      id: 'group_1',
      name: 'Tommy\'s Group',
      imageUrl: 'assets/images/group_1.jpg',
      participantIds: [tommyId, louisanaId, cristoferId],
      messages: messages,
      lastActivity: messages.first.timestamp,
    );
  }
}
