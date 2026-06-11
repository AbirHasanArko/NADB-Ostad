import 'package:flutter/material.dart';
import 'quiz_home_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.quiz,
              size: 100,
              color: Color(0xFF6A5AE0),
            ),
            const SizedBox(height: 24),
            const Text(
              'Quiz App',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 48),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizHomeScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                side: const BorderSide(color: Color(0xFFE5E5E5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Enter',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF6A5AE0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
