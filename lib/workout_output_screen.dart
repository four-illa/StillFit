import 'package:flutter/material.dart';

class WorkoutOutputScreen extends StatelessWidget {
  final List<Map<String, dynamic>> workoutData;

  const WorkoutOutputScreen({super.key, required this.workoutData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Workout Plan")),
      body: ListView.builder(
        itemCount: workoutData.length,
        itemBuilder: (context, index) {
          final item = workoutData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['exercise'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(item['description']),
                  SizedBox(height: 10),
                  Text('Sets: ${item['sets']} | Reps: ${item['reps']}', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
