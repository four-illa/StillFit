import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loading_screen.dart';

class MusclePage extends StatefulWidget {
  const MusclePage({super.key});

  @override
  State<MusclePage> createState() => _MusclePageState();
}

class _MusclePageState extends State<MusclePage> {
  Duration workoutDuration = Duration(minutes: 10);
  String selectedTargetArea = '';
  Set<String> selectedMuscles = {};
  String selectedEquipmentType = '';
  Set<String> selectedEquipment = {};
  String userPrompt = '';

  final upperMuscles = ['Chest', 'Arms', 'Shoulders', 'Back'];
  final lowerMuscles = ['Quads', 'Hamstrings', 'Glutes', 'Calves'];
  final coreMuscles = ['Abs'];
  final equipmentOptions = ['Dumbbells', 'Kettlebells', 'Barbell', 'Machine', 'Resistance Bands'];

  List<String> getMuscles() {
    switch (selectedTargetArea) {
      case 'Upper':
        return upperMuscles;
      case 'Lower':
        return lowerMuscles;
      case 'Core':
        return coreMuscles;
      default:
        return [];
    }
  }

  Widget _buildCupertinoTimer() {
    return Column(
      children: [
        Text('How long we\'ve got?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm, // ✅ FIXED: Use 'hm' for hours and minutes
            initialTimerDuration: workoutDuration,
            minuteInterval: 1,
            onTimerDurationChanged: (Duration newDuration) {
              setState(() {
                workoutDuration = newDuration;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTargetSelector() {
    final options = ['Upper', 'Lower', 'Core', 'Full Body'];
    return Wrap(
      spacing: 10,
      children: options.map((area) {
        return ChoiceChip(
          label: Text(area),
          selected: selectedTargetArea == area,
          onSelected: (_) {
            setState(() {
              selectedTargetArea = area;
              selectedMuscles.clear();
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildMuscleSelector() {
    final muscles = getMuscles();

    return Wrap(
      spacing: 10,
      children: muscles.map((muscle) {
        final isSelected = selectedMuscles.contains(muscle);
        return FilterChip(
          label: Text(muscle),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                selectedMuscles.add(muscle);
              } else {
                selectedMuscles.remove(muscle);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildEquipmentTypeSelector() {
    final types = ['Bodyweight', 'Equipment', 'Hybrid'];

    return Wrap(
      spacing: 10,
      children: types.map((type) {
        return ChoiceChip(
          label: Text(type),
          selected: selectedEquipmentType == type,
          onSelected: (_) {
            setState(() {
              selectedEquipmentType = type;
              selectedEquipment.clear();
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildEquipmentOptions() {
    return Wrap(
      spacing: 10,
      children: equipmentOptions.map((equip) {
        final isSelected = selectedEquipment.contains(equip);
        return FilterChip(
          label: Text(equip),
          selected: isSelected,
          onSelected: (val) {
            setState(() {
              if (val) {
                selectedEquipment.add(equip);
              } else {
                selectedEquipment.remove(equip);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildPromptBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Optional: Anything specific you want?", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        TextField(
          onChanged: (val) => setState(() => userPrompt = val),
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'e.g., I want to focus on strength over endurance',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  void _startWorkout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoadingScreen()),
    );
  }

  bool get showStartButton {
    if (selectedTargetArea == '') return false;
    if (selectedTargetArea != 'Full Body' && selectedMuscles.isEmpty) return false;
    if (selectedEquipmentType == '') return false;
    if ((selectedEquipmentType == 'Equipment' || selectedEquipmentType == 'Hybrid') &&
        selectedEquipment.isEmpty) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Build Your Muscle Plan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCupertinoTimer(),
            SizedBox(height: 24),
            Text('Target Area', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildTargetSelector(),
            SizedBox(height: 24),
            if (selectedTargetArea != 'Full Body' && selectedTargetArea.isNotEmpty) ...[
              Text('Target Muscles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildMuscleSelector(),
              SizedBox(height: 24),
            ],
            Text('Equipment Type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildEquipmentTypeSelector(),
            SizedBox(height: 16),
            if (selectedEquipmentType == 'Equipment' || selectedEquipmentType == 'Hybrid') ...[
              Text('Select Equipment:', style: TextStyle(fontSize: 16)),
              _buildEquipmentOptions(),
              SizedBox(height: 24),
            ],
            _buildPromptBox(),
            SizedBox(height: 24),
            if (showStartButton)
              Center(
                child: ElevatedButton(
                  onPressed: _startWorkout,
                  child: Text('Start', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}