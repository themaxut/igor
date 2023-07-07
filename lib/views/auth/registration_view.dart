import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';
import '../../services/auth/bloc/auth_state.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  late final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _verifyPasswordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _verifyPasswordController = TextEditingController();
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
        //  if (state is AuthStateRegistering) {
        //     if (state.exception is WeakPasswordAuthException) {
        //       await showErrorDialog(
        //         context,
        //         context.register_error_weak_password,
        //       );
        //     } else if (state.exception is EmailAlreadyInUseException) {
        //       await showErrorDialog(
        //         context,
        //         context.register_error_email_already_in_use,
        //       );
        //     } else if (state.exception is InvalidEmailAuthException) {
        //       await showErrorDialog(
        //         context,
        //         context.register_error_invalid_email,
        //       );
        //     } else if (state.exception is GenericAuthException) {
        //       await showErrorDialog(
        //         context,
        //         context.register_error_generic,
        //       );
        //     }
        //   }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // TODO: go back to login page
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
                      'assets/images/igor-2.png',
                      height: 150,
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'Aqcuire an Igor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'to whom does Igor answer?',
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
                            const SizedBox(height: 30),
                            TextFormField(
                              autocorrect: false,
                              controller: _passwordController,
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
                                labelText: 'Password',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 254, 238, 59),
                                    fontSize: 16,
                                    letterSpacing: 2),
                              ),
                              enableSuggestions: false,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30.0),
                            TextFormField(
                              autocorrect: false,
                              controller: _verifyPasswordController,
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
                                labelText: 'Confirm Password',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 254, 238, 59),
                                    fontSize: 16,
                                    letterSpacing: 2),
                              ),
                              enableSuggestions: false,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30.0),
                            ElevatedButton(
                              onPressed: () async {
                                // TODO: implement register logic
                                _formKey.currentState!.validate();

                                final email = _emailController.text;
                                final password = _passwordController.text;
                                context.read<AuthBloc>().add(
                                      AuthEventRegister(
                                        email,
                                        password,
                                      ),
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
                                'Register',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
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
                        const Text("Already have an Igor?"),
                        const SizedBox(
                          width: 75,
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: navigate to login screen
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
