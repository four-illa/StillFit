import 'package:flutter/material.dart';
import 'muscle_page.dart';
import 'cardio_page.dart';
import 'stretching_page.dart';

void main() => runApp(StillFitApp());

class StillFitApp extends StatelessWidget {
  const StillFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StillFit',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 60),
              Center(
                child: Text(
                  'StillFit',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  padding: EdgeInsets.all(20),
                  children: [
                    _sectionButton(context, label: 'Muscle', color: Colors.red),
                    _sectionButton(context, label: 'Cardio', color: Colors.green),
                    _sectionButton(context, label: 'Stretching', color: Colors.yellow[700]!),
                    Container(), // Filler for layout symmetry
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                Text("Jim 👋", style: TextStyle(fontWeight: FontWeight.bold)),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue[100],
                  child: Icon(Icons.person, size: 30, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionButton(BuildContext context, {required String label, required Color color}) {
    return GestureDetector(
      onTap: () {
        if (label == 'Muscle') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MusclePage()),
          );
        } else if (label == 'Cardio') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CardioPage()),
          );
        } else if (label == 'Stretching') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StretchingPage()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
