import 'package:flutter/material.dart';
import 'package:SportSpirit/features/data/sqlite/models/local_exercises_lite.dart';

class TrainingWidjet extends StatelessWidget {
  final List<ExercisesLite> boxExercises;
  final int index;

  const TrainingWidjet(
      {super.key, required this.boxExercises, required this.index});

  @override
  Widget build(BuildContext context) {
    List<String> uniqueMuscleGroups = [];

    for (ExercisesLite exercise in boxExercises) {
      if (!uniqueMuscleGroups.contains(exercise.muscleGroup)) {
        uniqueMuscleGroups.add(exercise.muscleGroup);
      }
    }
    String muscleGroupsText = uniqueMuscleGroups.join("/");

    return Container(
      height: 75,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 5.0,
            spreadRadius: 1.0,
            blurStyle: BlurStyle.outer,
            color: Colors.black26,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
        horizontalTitleGap: 10,
        minVerticalPadding: 2,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Тренировка №$index',
              softWrap: true,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[700]),
            ),
            Text(
              muscleGroupsText,
              softWrap: true,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.info_outline_rounded),
      ),
    );
  }
}
