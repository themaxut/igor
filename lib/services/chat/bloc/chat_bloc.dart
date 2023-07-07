import 'package:bloc/bloc.dart';
import 'package:igor/services/chat/openai_service.dart';

import '../../../models/chat_message.dart';
import '../../firestore/firestore_chat_message.dart';
import '../../firestore/firestore_service.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final OpenAIService openAIService;
  final FirestoreService firestoreService;
  final String userId;

  ChatBloc({
    required this.openAIService,
    required this.firestoreService,
    required this.userId,
  }) : super(ChatInitialized()) {
    on<SendMessageEvent>(_onSendMessageEvent);
    on<LoadChatHistoryEvent>(_onLoadChatHistoryEvent);
    on<ClearChatHistoryEvent>(_onClearChatHistoryEvent);
  }

  Future<void> _onSendMessageEvent(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    // Create a FirestoreChatMessage from the user's message
    final userMessage = FirestoreChatMessage(
      id: '', // Firestore will generate the id
      message: event.message.text,
      timestamp: DateTime.now(),
      userId: userId,
      isFromUser: true,
    );

    // write user's message to Firestore
    await firestoreService.addChatMessage(userId, userMessage);

    // Emit a new state to update the UI
    emit(ChatLoading(message: event.message));

    try {
      ChatMessage response = await openAIService.chat(event.message);

      // Create a FirestoreChatMessage from Igor's response
      final igorResponse = FirestoreChatMessage(
        id: '', // Firestore will generate the id
        message: response.text,
        timestamp: DateTime.now(),
        userId: userId,
        isFromUser: false,
      );

      // Save Igor's response to Firestore
      await firestoreService.addChatMessage(userId, igorResponse);

      // Emit a new state to update the UI
      emit(ChatResponseLoaded(message: response));
    } catch (error) {
      emit(ChatError(error: error.toString()));
    }
  }

  Future<void> _onLoadChatHistoryEvent(
      LoadChatHistoryEvent event, Emitter<ChatState> emit) async {
    // Load chat history from Firestore and emit as a state
    try {
      final chatHistory = await firestoreService.getChatHistory(userId).first;
      emit(ChatHistoryLoaded(chatHistory: chatHistory));
    } catch (error) {
      emit(ChatError(error: error.toString()));
    }
  }

  Future<void> _onClearChatHistoryEvent(
      ClearChatHistoryEvent event, Emitter<ChatState> emit) async {
    try {
      print('Attempting to clear chat history...'); // Debug print
      await firestoreService.clearChatHistory(userId);
      print('Chat history cleared, reloading...'); // Debug print

      final chatHistory = await firestoreService.getChatHistory(userId).first;
      emit(ChatHistoryLoaded(chatHistory: chatHistory));
    } catch (error) {
      emit(ChatError(error: error.toString()));
    }
  }
}
