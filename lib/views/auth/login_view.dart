import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
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
                'assets/images/igor-2.png',
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
              TextField(
                controller: emailController,
                cursorColor: Colors.purpleAccent,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Colors.purpleAccent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Colors.purpleAccent, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Colors.purpleAccent, width: 2.0),
                  ),
                  labelText: 'Email Address',
                  labelStyle: const TextStyle(
                    color: Colors.purpleAccent,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30.0),
              TextField(
                controller: passwordController,
                cursorColor: Colors.purpleAccent,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Colors.purpleAccent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Colors.purpleAccent, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Colors.purpleAccent, width: 2.0),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors.purpleAccent,
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30.0),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: navigate to forgot password screen
                    },
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Colors.purpleAccent[400],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: implement login auth
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            30.0), // specify the radius for your button here
                      ),
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
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
                    child: Text(
                      'Acquire an Igor',
                      style: TextStyle(
                        color: Colors.purpleAccent[400],
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
