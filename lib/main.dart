// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:igor/services/chat/bloc/chat_bloc.dart';
import 'package:igor/services/chat/openai_service.dart';
import 'package:igor/views/chat/chat_view.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;
  runApp(const IgorApp());
}

class IgorApp extends StatelessWidget {
  const IgorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Igor',
      theme: ThemeData.dark(),
      home: BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(apiService: OpenAIService()),
        child: const ChatView(),
      ),
    );
  }
}
