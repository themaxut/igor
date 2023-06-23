// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:igor/views/chat/greeting_chat_view.dart';
import '../../models/chat_message.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmit(String text) {
    _textController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      isFromUser: true,
    );
    setState(() {
      _messages.insert(0, message);
    });

    //Mock response from Igor
    ChatMessage response = ChatMessage(
      text: 'Some response',
      isFromUser: false,
    );
    setState(() {
      _messages.insert(0, response);
    });
  }

  // Decice what to show based on if there are any messages
  Widget _buildChatBody() {
    if (_messages.isEmpty) {
      return const GreetingChatView();
    } else {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (_, int index) => _buildMessageRow(_messages[index]),
          itemCount: _messages.length,
          padding: const EdgeInsets.all(8.0),
          reverse: true,
        ),
      );
    }
  }

  Widget _buildMessageRow(ChatMessage message) {
    return Row(
      crossAxisAlignment: message.isFromUser
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        message.isFromUser
            ? const Expanded(child: SizedBox())
            : Image.asset(
                'assets/images/igor-2.png',
                height: 40,
                width: 40,
              ),
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: message.isFromUser
                ? Colors.deepPurple[800]
                : Colors.blueGrey[700],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message.text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        message.isFromUser
            ? Image.asset(
                'assets/images/igor-main.png',
                height: 40,
                width: 40,
              )
            : const Expanded(
                child: SizedBox(),
              ),
      ],
    );

    // return ListTile(
    //   leading: message.sender == 'Igor'
    //       ? Image.asset(
    //           'assets/images/igor-2.png',
    //           height: 30,
    //           width: 30,
    //         )
    //       : null,
    //   title: Text(message.sender),
    //   subtitle: Text(message.message),
    // );
  }

  @override
  Widget build(BuildContext context) {
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
            _buildChatBody(), // show either the greeting or the messages
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
  }
}
