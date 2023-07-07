// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GreetingChatView extends StatelessWidget {
  const GreetingChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/igor-2.png',
              height: 150,
              width: 150,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Text(
                'Oh, the Igor life!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Here goes Igor, yet again...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
