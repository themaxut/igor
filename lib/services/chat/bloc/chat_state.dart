import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../../models/chat_message.dart';
import '../../firestore/firestore_chat_message.dart';

@immutable
abstract class ChatState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class ChatInitialized extends ChatState {}

class ChatLoading extends ChatState {
  final ChatMessage message;

  ChatLoading({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ChatResponseLoaded extends ChatState {
  final ChatMessage message;

  ChatResponseLoaded({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ChatError extends ChatState {
  final String error;

  ChatError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ChatHistoryLoaded extends ChatState {
  final List<FirestoreChatMessage> chatHistory;

  ChatHistoryLoaded({required this.chatHistory});

  @override
  List<Object> get props => [chatHistory];
}

class ChatHistoryDeleting extends ChatState {}
