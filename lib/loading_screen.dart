import 'workout_output_screen.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => WorkoutOutputScreen(
            workoutData: [
              {
                'exercise': 'Push-Up',
                'description': 'Keep your core tight and lower yourself until elbows are 90°.',
                'sets': 3,
                'reps': 12,
              },
              {
                'exercise': 'Dumbbell Press',
                'description': 'Press the weights upward while lying flat.',
                'sets': 4,
                'reps': 10,
              },
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Generating your StillFit exercise plan…",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 40),
            Icon(Icons.fitness_center, size: 50, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
