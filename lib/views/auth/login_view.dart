import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                'Igor Welcomes You',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ever at your service, ready for the next task',
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
                        cursorColor: const Color.fromARGB(255, 254, 238, 59),
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
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 254, 238, 59),
                              fontSize: 16,
                              letterSpacing: 2),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value!.isEmpty) return 'Email cannot be empty';
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        autocorrect: false,
                        controller: passwordController,
                        cursorColor: const Color.fromARGB(255, 254, 238, 59),
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
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 254, 238, 59),
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                        ),
                        enableSuggestions: false,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) return 'Password cannot be empty';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: navigate to forgot password screen
                    },
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 254, 238, 59),
                      ),
                    ),
                  ),
                  const Spacer(),
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
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[300],
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an Igor?"),
                  const SizedBox(
                    width: 75,
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: navigate to registration screen
                    },
                    child: const Text(
                      'Acquire an Igor',
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
    );
  }
}
