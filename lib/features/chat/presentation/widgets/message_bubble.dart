import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.72,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.OutLineColor, width: 1),
            color:
                isCurrentUser
                    ? AppTheme.userChatBubbleFill
                    : AppTheme.otherChatBubbleFill,
            borderRadius: BorderRadius.only(
              bottomLeft:
                  isCurrentUser
                      ? const Radius.circular(40)
                      : const Radius.circular(0),
              bottomRight:
                  isCurrentUser
                      ? const Radius.circular(0)
                      : const Radius.circular(40),
              topLeft:
                  isCurrentUser
                      ? const Radius.circular(40)
                      : const Radius.circular(0),
              topRight:
                  isCurrentUser
                      ? const Radius.circular(0)
                      : const Radius.circular(40),
            ),
            boxShadow:
                !isCurrentUser
                    ? [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(-2, 2),
                      ),
                    ]
                    : null,
          ),
          padding: EdgeInsets.only(
            left: isCurrentUser ? 24 : 12.0,
            right: 18.0,
            bottom: 10.0,
            top: 10.0,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isCurrentUser)
                    Wrap(
                      spacing: 4,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.userChatAvatarOutline,
                              width: 2.0,
                              strokeAlign: BorderSide.strokeAlignOutside
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 16.0,
                            backgroundImage: NetworkImage(
                              message.avatarUrl,
                            ),
                          ),
                        ),
                        const SizedBox(width: 1),
                        Text(
                          message.senderName,
                          style: GoogleFonts.playfairDisplay(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: Color(int.tryParse(message.color ?? '0xff000000') ?? 0xff000000),
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      message.content,
                      style: AppTheme.messageTextStyle(
                        isCurrentUser: isCurrentUser,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        DateFormat('HH:mm').format(message.timestamp),
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.mintGreen,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
