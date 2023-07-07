import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igor/services/chat/bloc/chat_event.dart';
import 'package:igor/utilities/dialogs/clear_history_dialog.dart';
import 'package:igor/views/chat/greeting_chat_view.dart';
import '../../components/typing_indicator.dart';
import '../../helpers/loading/loading_screen.dart';
import '../../models/chat_message.dart';

import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';
import '../../services/chat/bloc/chat_bloc.dart';
import '../../services/chat/bloc/chat_state.dart';
import '../../utilities/dialogs/logout_dialog.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  ChatViewState createState() => ChatViewState();
}

class ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late final ValueNotifier<List<ChatMessage>> _messagesNotifier;
  // final openaiService = OpenAIService();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadChatHistoryEvent());
    _messagesNotifier = ValueNotifier<List<ChatMessage>>(_messages);
  }

  void _handleSubmit(String text) async {
    _textController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      isFromUser: true,
    );

    _messagesNotifier.value.insert(0, message);

    ChatMessage loadingMessage = ChatMessage(
      text: 'Typing...',
      isFromUser: false,
      isLoading: true, // Mark this message as loading
    );
    _messagesNotifier.value.insert(0, loadingMessage);

    BlocProvider.of<ChatBloc>(context).add(SendMessageEvent(message: message));

    // // Response using the OpenAIService
    // try {
    //   ChatMessage response = await openaiService.chat(message);

    //   //Mock response from Igor
    //   // ChatMessage response = ChatMessage(
    //   //   text:
    //   //       'Some extremely long response Some extremely long response Some extremely long response Some extremely long response Some extremely long response Some extremely long response',
    //   //   isFromUser: false,
    //   // );

    //   setState(() {
    //     _messages.insert(0, response);
    //   });
    // } catch (e) {
    //   ChatMessage errorResponse = ChatMessage(
    //     text: e.toString(),
    //     isFromUser: false,
    //   );

    //   setState(() {
    //     _messages.insert(0, errorResponse);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatResponseLoaded) {
          _messagesNotifier.value.removeAt(0);
          _messagesNotifier.value.insert(0, state.message);
        } else if (state is ChatHistoryDeleting) {
          LoadingScreen().show(
            context: context,
            text: 'Clearing chat',
          );
        } else if (state is ChatHistoryLoaded) {
          LoadingScreen().hide();
          _messagesNotifier.value = state.chatHistory
              .map(
                (firestoreMessage) => ChatMessage(
                    text: firestoreMessage.message,
                    isFromUser: firestoreMessage.isFromUser),
              )
              .toList();
        }
      },
      builder: (context, state) {
        return MaterialApp(
          title: 'Igor',
          theme: ThemeData.dark(),
          home: Scaffold(
            appBar: AppBar(
              title: const Text(
                'It is your Igor, master!',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: const Color.fromARGB(255, 254, 238, 59),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.restart_alt_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    final shouldClearHistory =
                        await showClearHistoryDialog(context);
                    if (shouldClearHistory) {
                      _messages.clear();
                      context.read<ChatBloc>().add(
                            ClearChatHistoryEvent(),
                          );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.black),
                  onPressed: () async {
                    final shouldLogout = await showLogoutDialog(context);
                    if (shouldLogout) {
                      context.read<AuthBloc>().add(
                            const AuthEventLogout(),
                          );
                    }
                  },
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                _buildChatBody(
                    state), // show either the greeting or the messages
                const Divider(
                  height: 1.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/igor-main.png',
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          onSubmitted: _handleSubmit,
                          maxLines: 3,
                          minLines: 1,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 254, 238, 59),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 254, 238, 59),
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 254, 238, 59),
                                  width: 2.0),
                            ),
                            hintText: 'Enter your wishes here master',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _handleSubmit(_textController.text);
                        },
                        icon: const Icon(Icons.send),
                        color: const Color.fromARGB(255, 254, 238, 59),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Decide what to show based on if there are any messages
  Widget _buildChatBody(ChatState state) {
    return ValueListenableBuilder(
      valueListenable: _messagesNotifier,
      builder: (context, List<ChatMessage> messages, child) {
        if (messages.isEmpty) {
          return const GreetingChatView();
        } else {
          return Expanded(
            child: ListView.builder(
              itemBuilder: (_, int index) =>
                  _buildMessageRow(state, messages[index]),
              itemCount: messages.length,
              padding: const EdgeInsets.all(8.0),
              reverse: true,
            ),
          );
        }
      },
    );
  }

  Widget _buildMessageRow(ChatState state, ChatMessage message) {
    if (message.isLoading) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/igor-2.png',
            height: 40,
            width: 40,
          ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[700],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const TypingIndicator(),
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isFromUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          message.isFromUser
              ? const Expanded(child: SizedBox())
              : Image.asset(
                  'assets/images/igor-2.png',
                  height: 40,
                  width: 40,
                ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: message.isFromUser
                  ? const Color.fromARGB(255, 254, 238, 59)
                  : const Color.fromARGB(255, 194, 195, 195),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              children: [
                Text(
                  message.text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          message.isFromUser
              ? Image.asset(
                  'assets/images/igor-main.png',
                  height: 40,
                  width: 40,
                )
              : const Expanded(child: SizedBox()),
        ],
      );
    }
  }
}
