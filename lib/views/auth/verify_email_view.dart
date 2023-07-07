import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';
import '../../services/auth/bloc/auth_state.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  context.read<AuthBloc>().add(
                        const AuthEventLogout(),
                      );
                },
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/igor-main.png',
                      height: 150,
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'Tether your Igor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Igor must find master!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 45.0),
                    Text(
                      'An email has been sent to you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[400],
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      'Click on the email link to help this new Igor find its Master',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[400],
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () async {
                        context.read<AuthBloc>().add(
                              const AuthEventLogout(),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 254, 238, 59),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 60,
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      "Didn't receive an email?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 30),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              const AuthEventSendEmailVerification(),
                            );
                      },
                      child: const Text(
                        'Resend Email Verification',
                        style: TextStyle(
                          color: Color.fromARGB(255, 254, 238, 59),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
