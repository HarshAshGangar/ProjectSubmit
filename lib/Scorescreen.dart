import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'quizscreen.dart';

class ScoreScreen extends StatefulWidget {
  final int right;
  final int wrong;
  final int total;

  const ScoreScreen({
    Key? key,
    required this.right,
    required this.wrong,
    required this.total,
  }) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  bool _showScores = false;

  @override
  void initState() {
    super.initState();
    // Delay to show scores after the animation
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showScores = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Choose the animation based on the total score
    final animationPath = widget.total < 10
        ? 'assets/animations/Animation - 1737280819469.json' // Animation for low score
        : 'assets/animations/Animation - 1737280264462.json'; // Animation for high score

    return Scaffold(
      body: Container(
        color: const Color(0xFF333333), // Background color
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _showScores
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quiz Results',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Right Answer Score: ${widget.right}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white, // White text
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Wrong Answer Score: ${widget.wrong}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white, // White text
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Total Score: ${widget.total}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Not satisfied? Take the test again!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // White text
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to QuizScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuizScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button background color
                  foregroundColor: Color(0xFF333333),
                  minimumSize: const Size(50, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),// Button text color
                ),
                child: const Text('Retake Quiz'),
              ),
            ],
          )
              : FittedBox(
            fit: BoxFit.cover, // Ensures the animation fits the screen
            child: Lottie.asset(
              animationPath, // Dynamically select animation
              width: MediaQuery.of(context).size.width, // Full screen width
              height: MediaQuery.of(context).size.height, // Full screen height
            ),
          ),
        ),
      ),
    );
  }
}
