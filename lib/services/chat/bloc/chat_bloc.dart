import 'package:bloc/bloc.dart';
import 'package:igor/services/chat/openai_service.dart';

import '../../../models/chat_message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final OpenAIService apiService;

  ChatBloc({
    required this.apiService,
  }) : super(ChatInitialized()) {
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  Future<void> _onSendMessageEvent(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading(message: event.message));

    try {
      ChatMessage response = await apiService.chat(event.message);

      // Emit a new state to update the UI
      emit(ChatResponseLoaded(message: response));
    } catch (error) {
      emit(ChatError(error: error.toString()));
    }
  }
}
