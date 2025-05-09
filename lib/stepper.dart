import 'package:flutter/material.dart';

class stepper extends StatelessWidget {

  final int currentstep;

  stepper({required this.currentstep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildStep("1", "Registration", currentstep >= 1),
        buildDivider(),
        buildStep("2", "Review & Pay", currentstep >= 2),
      ],
    );
  }
}

Widget buildStep(String stepNumber, String title, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: isActive ? Colors.blue : Colors.grey,
            child: Text(stepNumber, style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(color: isActive ? Colors.blue : Colors.grey)),
        ],
      ),
    );
  }

  
  Widget buildDivider() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey,
      ),
    );
  }
