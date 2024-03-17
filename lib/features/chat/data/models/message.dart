import 'package:equatable/equatable.dart';
import 'package:shoplo_client/features/auth/domain/entities/user.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.chatId,
    required this.sender,
    required this.senderType,
    required this.message,
    required this.messageType,
    required this.createdAt,
  });
  final int id;
  final int chatId;
  final User sender;
  final String senderType;
  final String message;
  final String messageType;
  final String createdAt;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      chatId: json['chat_id'],
      sender: User.fromJson(json['sender']),
      senderType: json['sender_type'],
      message: json['message'],
      messageType: json['message_type'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['chat_id'] = chatId;
    data['sender'] = sender.toJson();
    data['sender_type'] = senderType;
    data['message'] = message;
    data['message_type'] = messageType;
    data['created_at'] = createdAt;
    return data;
  }

  @override
  List<Object> get props {
    return [
      id,
      chatId,
      sender,
      senderType,
      message,
      messageType,
      createdAt,
    ];
  }
}
