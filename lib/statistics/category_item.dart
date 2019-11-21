import 'package:flutter/material.dart';

import 'meet_results/meet_results_setup_screen.dart';
import 'athletes_attendance/athletes_attendance_setup_screen.dart';
import 'training_plan/training_plan_setup_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;

  CategoryItem(this.title, this.color);

  void selectCategory(BuildContext ctx) {
    if (this.title == 'Meet Results') {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => MeetResultsSetupScreen(),
        ),
      );
    } else if (this.title == 'Athletes Attendance') {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => AthletesAttendanceSetupScreen(),
        ),
      );
    } else if (this.title == 'Training Plan') {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => TrainingPlanSetupScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
