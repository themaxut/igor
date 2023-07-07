import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // TODO: go back to login page
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
                            controller: emailController,
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
                              if (value!.isEmpty)
                                return 'Email cannot be empty';
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
                      // TODO: implement login auth
                      _formKey.currentState!.validate();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 254, 238, 59),
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
                          // TODO: navigate to login screen
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
    );
  }
}
