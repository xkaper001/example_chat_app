import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/group_chat.dart';
import '../bloc/group_chat_bloc.dart';
import 'group_chat_screen.dart';

class GroupChatListScreen extends StatefulWidget {
  const GroupChatListScreen({Key? key}) : super(key: key);

  @override
  State<GroupChatListScreen> createState() => _GroupChatListScreenState();
}

class _GroupChatListScreenState extends State<GroupChatListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GroupChatBloc>(context).add(const LoadGroupChats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Group Chats',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkGrey,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.darkGrey),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<GroupChatBloc, GroupChatState>(
        builder: (context, state) {
          if (state is GroupChatsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GroupChatsLoaded) {
            return _buildGroupChatsList(state.groupChats);
          } else if (state is GroupChatError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('No group chats found'));
        },
      ),
    );
  }

  Widget _buildGroupChatsList(List<GroupChat> groupChats) {
    return ListView.separated(
      itemCount: groupChats.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final groupChat = groupChats[index];
        final lastMessage = groupChat.messages.isNotEmpty
            ? groupChat.messages.first
            : null;        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: AppTheme.mintGreen,
            child: Text(
              groupChat.name.substring(0, 1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // If you had actual images, you would use this:
            // backgroundImage: AssetImage(groupChat.imageUrl),
          ),
          title: Text(
            groupChat.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: AppTheme.darkGrey,
            ),
          ),
          subtitle: lastMessage != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${lastMessage.senderName}: ${lastMessage.content}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                )
              : const Text('No messages yet'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [              Text(
                DateFormat('h:mm a').format(groupChat.lastActivity),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 4),
              _buildUnreadBadge(groupChat),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupChatScreen(groupId: groupChat.id),
              ),
            );
          },
        );
      },
    );
  }
  Widget _buildUnreadBadge(GroupChat groupChat) {
    // Count unread messages
    final unreadCount = groupChat.messages.where((msg) => !msg.isRead).length;
    
    if (unreadCount > 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: AppTheme.mintGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          unreadCount.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
