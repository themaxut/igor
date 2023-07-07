import 'package:flutter/foundation.dart' show immutable;

import '../../../models/chat_message.dart';
import '../../firestore/firestore_chat_message.dart';

@immutable
abstract class ChatState {}

class ChatInitialized extends ChatState {}

class ChatLoading extends ChatState {
  final ChatMessage message;

  ChatLoading({
    required this.message,
  });
}

class ChatResponseLoaded extends ChatState {
  final ChatMessage message;

  ChatResponseLoaded({
    required this.message,
  });
}

class ChatError extends ChatState {
  final String error;

  ChatError({
    required this.error,
  });
}

class ChatHistoryLoaded extends ChatState {
  final List<FirestoreChatMessage> chatHistory;

  ChatHistoryLoaded({required this.chatHistory});
}
