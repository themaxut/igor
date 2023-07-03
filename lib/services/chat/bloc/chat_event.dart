import 'package:flutter/foundation.dart';
import 'package:igor/models/chat_message.dart';

@immutable
abstract class ChatEvent {
  const ChatEvent();
}

class SendMessageEvent extends ChatEvent {
  final ChatMessage message;

  const SendMessageEvent({
    required this.message,
  });
}
