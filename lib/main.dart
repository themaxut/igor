// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:igor/views/chat/chat_view.dart';

void main() {
  runApp(const IgorApp());
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
