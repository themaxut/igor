import 'package:flutter/material.dart';
import 'package:igor/views/chat_view.dart';

void main() {
  runApp(IgorApp());
}

class IgorApp extends StatelessWidget {
  const IgorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Igor',
      theme: ThemeData.dark(),
      home: const ChatView(),
    );
  }
}
