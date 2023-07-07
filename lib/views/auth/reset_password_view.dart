import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth/auth_exceptions.dart';
import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';
import '../../services/auth/bloc/auth_state.dart';
import '../../utilities/dialogs/error_dialog.dart';
import '../../utilities/dialogs/password_reset_send_dialog.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _emailController.clear();
            await showPasswordResetSendDialog(
              context,
            );
          }
          if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
              context,
              'The email you provided is invalid',
            );
          } else if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              'Please make sure you are a registered user',
            );
          } else {
            await showErrorDialog(
              context,
              'We could not process your request. Please make sure that you are a registered user, or if not, register a user now by going back one step.',
            );
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
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
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Is your Igor disobeying?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 45.0),
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              cursorColor:
                                  const Color.fromARGB(255, 254, 238, 59),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 254, 238, 59),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 254, 238, 59),
                                      width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 254, 238, 59),
                                      width: 2.0),
                                ),
                                labelText: 'Email Address',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "Enter your email address",
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 254, 238, 59),
                                    fontSize: 16,
                                    letterSpacing: 2),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email cannot be empty';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.validate();
                        final email = _emailController.text;
                        context.read<AuthBloc>().add(
                              AuthEventForgotPassword(email: email),
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
                        "Reset Igor's password",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("My Igor Obeys:"),
                        const SizedBox(
                          width: 30,
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  const AuthEventLogout(),
                                );
                          },
                          child: const Text(
                            'Summon my Igor',
                            style: TextStyle(
                              color: Color.fromARGB(255, 254, 238, 59),
                            ),
                          ),
                        ),
                      ],
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
