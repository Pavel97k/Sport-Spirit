import 'package:flutter/material.dart';
import 'package:sport_spirit/features/data/sqlite/models/local_exercises_lite.dart';
import 'package:sport_spirit/features/presentation/screens/exercise_info.dart';
import 'package:sport_spirit/features/presentation/widjets/training.dart';

class BoxExercise extends StatelessWidget {
  final List<ExercisesLite> boxExercises;
  final int number;

  const BoxExercise(
      {super.key, required this.boxExercises, required this.number});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Набор с упражнениями',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 100,
              child: TrainingWidjet(
                boxExercises: boxExercises,
                index: number,
              ),
            ),
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: boxExercises.length,
                itemBuilder: (context, index) {
                  final item = boxExercises[index];
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExerciseInfo(
                                  boxExercises: item,
                                  idCriterions: item.exerciseCriteriaId,
                                  isHandbook: false,
                                ),
                              ),
                            );
                          },
                          leading: const Icon(Icons.sports_kabaddi_sharp),
                          title: Text(
                            item.exerciseName,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            item.muscleGroup,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const Divider(
                        endIndent: 50,
                        indent: 50,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
