import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String content;
  final String senderId;
  final String senderName;
  final String avatarUrl;
  final String? color;
  final DateTime timestamp;
  final bool isRead;

  const Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
    this.avatarUrl = 'https://img.freepik.com/premium-photo/ai-human-avatar-characters-male-model_1166271-38.jpg',
    this.color,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [id, content, senderId, timestamp, isRead];
}
