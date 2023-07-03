// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igor/services/chat/bloc/chat_event.dart';
import 'package:igor/views/chat/greeting_chat_view.dart';
import '../../models/chat_message.dart';

import '../../services/chat/bloc/chat_bloc.dart';
import '../../services/chat/bloc/chat_state.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  ChatViewState createState() => ChatViewState();
}

class ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late AnimationController _animationController;
  late final ValueNotifier<List<ChatMessage>> _messagesNotifier;
  // final openaiService = OpenAIService();

  @override
  void initState() {
    super.initState();

    _messagesNotifier = ValueNotifier<List<ChatMessage>>(_messages);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
        }
      },
      builder: (context, state) {
        return MaterialApp(
          title: 'Igor',
          theme: ThemeData.dark(),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('It is your Igor, master!'),
              backgroundColor: Colors.deepPurple,
              //TODO: add Logout button
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
                                  color: Colors.deepPurpleAccent, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurpleAccent, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurpleAccent, width: 2.0),
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
                        color: Colors.deepPurpleAccent,
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
            child: _buildTypingIndicator(),
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
                  ? Colors.deepPurple[800]
                  : Colors.blueGrey[700],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              children: [
                Text(
                  message.text,
                  style: const TextStyle(
                    fontSize: 16,
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

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text('Igor is typing'),
          AnimatedIcon(
            icon: AnimatedIcons.arrow_menu,
            progress: _animationController,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
