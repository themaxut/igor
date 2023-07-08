import 'package:igor/models/chat_message.dart';
import 'package:igor/services/chat/bloc/chat_bloc.dart';
import 'package:igor/services/chat/bloc/chat_event.dart';
import 'package:igor/services/chat/bloc/chat_state.dart';
import 'package:igor/services/chat/openai_service.dart';
import 'package:igor/services/firestore/firestore_chat_message.dart';
import 'package:igor/services/firestore/firestore_service.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'chat_test.mocks.dart';

@GenerateMocks([OpenAIService, FirestoreService, ChatBloc])
void main() {
  late ChatBloc chatBloc;
  late MockOpenAIService mockOpenAIService;
  late MockFirestoreService mockFirestoreService;

  setUp(
    () {
      mockOpenAIService = MockOpenAIService();
      mockFirestoreService = MockFirestoreService();
      chatBloc = ChatBloc(
        openAIService: mockOpenAIService,
        firestoreService: mockFirestoreService,
        userId: 'test',
      );
    },
  );

  test(
    'initial state is correct',
    () {
      expect(chatBloc.state, ChatInitialized());
    },
  );

  test(
    'SendMessageEvent successfully sends a message and receives response',
    () async {
      when(mockOpenAIService.chat(any)).thenAnswer(
        (_) async => ChatMessage(
          text: 'Response text',
          isFromUser: false,
        ),
      );
      chatBloc.add(
        SendMessageEvent(
          message: ChatMessage(
            text: 'Test message',
            isFromUser: true,
          ),
        ),
      );
      await expectLater(
        chatBloc.stream,
        emitsInOrder(
          [
            isA<ChatLoading>(), // Emitting the ChatLoading state first
            isA<ChatResponseLoaded>(), // Then expecting a ChatResponseLoaded state
          ],
        ),
      );
    },
  );

  test('LoadChatHistoryEvent successfully loads chat history', () async {
    when(mockFirestoreService.getChatHistory('test')).thenAnswer(
      (_) => Stream.value([
        FirestoreChatMessage(
            message: 'Previous message',
            timestamp: DateTime.now(),
            userId: 'test',
            isFromUser: true,
            id: '1')
      ]),
    );
    chatBloc.add(LoadChatHistoryEvent());
    await expectLater(
      chatBloc.stream,
      emitsInOrder([
        isA<ChatHistoryLoaded>() // Expecting a ChatHistoryLoaded state
      ]),
    );
  });

  test('ClearChatHistoryEvent successfully clears chat history', () async {
    when(
      mockFirestoreService.clearChatHistory('test'),
    ).thenAnswer(
      (_) async => {},
    );
    when(
      mockFirestoreService.getChatHistory('test'),
    ).thenAnswer(
      (_) => Stream.value([]),
    );
    chatBloc.add(
      ClearChatHistoryEvent(),
    );
    await expectLater(
        chatBloc.stream,
        emitsInOrder([
          isA<ChatHistoryDeleting>(), // Emitting the ChatHistoryDeleting state first
          isA<ChatHistoryLoaded>() // Then expecting a ChatHistoryLoaded state with empty chat history
        ]));
  });

  //Bloc tests
  test(
    'emits expected states when SendMessageEvent is added',
    () async {
      final userMessage = ChatMessage(
        text: "Master's message",
        isFromUser: true,
      );
      final aiMessage = ChatMessage(
        text: 'Response from Igor',
        isFromUser: false,
      );

      when(
        mockOpenAIService.chat(
          userMessage,
        ),
      ).thenAnswer((_) async => aiMessage);
      when(
        mockFirestoreService.addChatMessage(
          any,
          any,
        ),
      ).thenAnswer(
        (_) async {},
      );

      final expectedStates = [
        ChatLoading(
          message: userMessage,
        ),
        ChatResponseLoaded(
          message: aiMessage,
        ),
      ];

      expectLater(
        chatBloc.stream,
        emitsInOrder(expectedStates),
      );

      chatBloc.add(
        SendMessageEvent(
          message: userMessage,
        ),
      );
    },
  );

  // Negative cases
  test('SendMessageEvent returns error when OpenAIService fails', () async {
    when(mockOpenAIService.chat(any)).thenThrow(
        Exception('Failed to send message. Error with OpenAIService'));
    chatBloc.add(
      SendMessageEvent(
        message: ChatMessage(
          text: 'Test message',
          isFromUser: true,
        ),
      ),
    );
    await expectLater(
      chatBloc.stream,
      emitsInOrder(
        [
          isA<ChatLoading>(), // Emitting the ChatLoading state first
          isA<ChatError>(), // Then expecting a ChatError state
        ],
      ),
    );
  });

  test(
    'LoadChatHistoryEvent returns error when FirestoreService fails',
    () async {
      when(mockFirestoreService.getChatHistory('test')).thenThrow(
        Exception('Failed to load chat history. Error with Firestore Service'),
      );
      chatBloc.add(LoadChatHistoryEvent());
      await expectLater(
        chatBloc.stream,
        emitsInOrder([
          isA<ChatError>(), // Expecting a ChatError state
        ]),
      );
    },
  );

  test(
    'ClearChatHistoryEvent returns error when FirestoreService fails',
    () async {
      when(mockFirestoreService.clearChatHistory('test')).thenThrow(
        Exception('Failed to clear chat history'),
      );
      chatBloc.add(ClearChatHistoryEvent());
      await expectLater(
        chatBloc.stream,
        emitsInOrder(
          [
            isA<ChatHistoryDeleting>(), // Expecting a ChatHistoryDeleting state
            isA<ChatError>(), // Then expecting a ChatError state
          ],
        ),
      );
    },
  );
}
