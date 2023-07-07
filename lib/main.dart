// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'helpers/loading/loading_screen.dart';
import 'services/auth/bloc/auth_bloc.dart';
import 'services/auth/bloc/auth_event.dart';
import 'services/auth/bloc/auth_state.dart';
import 'services/auth/firebase_auth_provider.dart';
import 'services/chat/bloc/chat_bloc.dart';
import 'services/chat/openai_service.dart';

import 'views/auth/login_view.dart';
import 'views/auth/registration_view.dart';
import 'views/auth/reset_password_view.dart';
import 'views/auth/verify_email_view.dart';
import 'views/chat/chat_view.dart';
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
        home: BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(FirebaseAuthProvider()),
          child: const MainPage(),
        )
        // home: BlocProvider<ChatBloc>(
        //     create: (context) => ChatBloc(apiService: OpenAIService()),
        //     child: const ChatView(),
        //     ),
        );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return BlocProvider<ChatBloc>(
            create: (context) => ChatBloc(apiService: OpenAIService()),
            child: const ChatView(),
          );
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ResetPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegistrationView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
