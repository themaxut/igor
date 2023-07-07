import 'package:dart_openai/dart_openai.dart';
import 'package:igor/models/chat_message.dart';

class OpenAIService {
  Future<ChatMessage> chat(ChatMessage message) async {
    if (message.isFromUser) {
      try {
        OpenAIChatCompletionModel chatCompletion =
            await OpenAI.instance.chat.create(
          model: "gpt-3.5-turbo",
          maxTokens:
              5, //TOOD: remove after dev/testing. Currently here to minimize usage charges.
          messages: [
            OpenAIChatCompletionChoiceMessageModel(
              content: message.text,
              role: OpenAIChatMessageRole.user,
            ),
          ],
        );

        // TODO: remove this after
        // print(chatCompletion.id);
        // print(chatCompletion.choices.first.message);

        if (chatCompletion.choices.isNotEmpty) {
          ChatMessage response = ChatMessage(
            text: chatCompletion.choices.first.message.content.toString(),
            isFromUser: false,
          );

          return response;
        } else {
          throw Exception("Received empty response from OpenAI.");
        }
      } catch (e) {
        throw Exception("Failed to get response from OpenAI: $e");
      }
    }

    throw Exception("Non-user attempted to send message to OpenAI");
  }
}
