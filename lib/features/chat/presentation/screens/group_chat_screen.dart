import 'package:example_chat_app/features/chat/presentation/widgets/appbar_background_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../bloc/group_chat_bloc.dart';
import '../widgets/chat_background_painter.dart';
import '../widgets/date_separator.dart';
import '../widgets/message_bubble.dart';

class GroupChatScreen extends StatefulWidget {
  final String groupId;

  const GroupChatScreen({super.key, required this.groupId});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GroupChatBloc>(
      context,
    ).add(LoadGroupChatDetails(widget.groupId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: CustomPaint(
            painter: AppbarBackgroundPainter(),
            size: Size.fromHeight(48),
            child: const SizedBox(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: BlocBuilder<GroupChatBloc, GroupChatState>(
          builder: (context, state) {
            if (state is GroupChatDetailsLoaded) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.userChatBubbleFill,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(0),
                    bottomLeft: const Radius.circular(24),
                    bottomRight: const Radius.circular(24),
                    topRight: const Radius.circular(0),
                  ),
                  border: Border.all(color: AppTheme.OutLineColor, width: 1),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 18,
                      child: ClipOval(
                        child: Text(
                          state.groupChat.name.substring(0, 1),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      state.groupChat.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.more_horiz),
                  ],
                ),
              );
            }
            return const Text('Group Chat');
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Center(
            child: CustomPaint(
              painter: ChatBackgroundPainter(),
              size: Size.fromWidth(300),
            ),
          ),
          // Chat content
          Column(
            children: [
              Expanded(
                child: BlocBuilder<GroupChatBloc, GroupChatState>(
                  builder: (context, state) {
                    if (state is GroupChatsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GroupChatDetailsLoaded) {
                      final messages = state.groupChat.messages;
                      final currentUserId =
                          'user_4'; // This should come from auth state or service
                      return ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isCurrentUser =
                              message.senderId == currentUserId;

                          // Add date separator before the first message of each day
                          Widget? separator;
                          final isFirstMessage = index == messages.length - 1;
                          final isNewDay =
                              !isFirstMessage &&
                              !_isSameDay(
                                message.timestamp,
                                messages[index + 1].timestamp,
                              );
                          if (isFirstMessage || isNewDay) {
                            separator = Center(
                              child: Text(
                                DateFormat(
                                  'd MMMM y',
                                ).format(message.timestamp),
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (separator != null) separator,
                              MessageBubble(
                                message: message,
                                isCurrentUser: isCurrentUser,
                              ),
                            ],
                          );
                        },
                      );
                    } else if (state is GroupChatError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const Center(
                      child: Text('Select a group chat to start messaging.'),
                    );
                  },
                ),
              ),
              _buildMessageInput(),
            ],
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _buildMessageInput() {
    return Container(
      margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 2),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            spreadRadius: 3,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
        borderRadius: BorderRadius.only(topLeft: const Radius.circular(60)),
        border: Border.all(color: AppTheme.mintGreen, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  hintStyle: TextStyle(
                    color: AppTheme.darkGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 5,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                child: Image.asset(
                  'assets/icons/mailbox.png',
                  width: 42.0,
                  fit: BoxFit.fitWidth,
                ),
                onTap: () {
                  // Send message functionality
                  // (we're not implementing this in the mock version)
                  if (_messageController.text.trim().isNotEmpty) {
                    // Clear the input
                    _messageController.clear();
                  }
                },
              ),
              // Camera icon
              Column(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.camera_alt, color: Color(0xFF4B7265), size: 28.0),
                  Image.asset(
                    'assets/icons/flag.png',
                    width: 32.0,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
