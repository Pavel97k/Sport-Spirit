import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/data/sqlite/models/local_exercises_lite.dart';
import 'package:sport_spirit/features/domain/api/cubit/exercises_cubit.dart';
import 'package:sport_spirit/features/presentation/screens/exercise_info.dart';

class HandbookInfo extends StatelessWidget {
  HandbookInfo({super.key});

  final cubit = service<ExercisesCubit>()
    ..getAllExercises(0, 0,
        collectionId: 0, unique: true, logic: false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Упражнения',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: null,
        ),
        body: BlocBuilder<ExercisesCubit, ExercisesState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is ExercisesInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ExercisesLoaded) {
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final item = state.data[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 3.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseInfo(
                              boxExercises: ExercisesLite(
                                  id: item.idExercise,
                                  exerciseName: item.exerciseName,
                                  exerciseDescriptions:
                                      item.exerciseDescriptions,
                                  muscleGroup: item.muscleGroup,
                                  exerciseCriteriaId: item.exerciseCriteriaId,
                                  collectionServerId: item.collectionServerId),
                              idCriterions: item.exerciseCriteriaId,
                              isHandbook: true,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/handbook_image.jpg'), // Путь к изображению
                              fit: BoxFit.cover,
                              opacity: 0.6),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 100.0,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.normal,
                              color: Colors.black26,
                              offset: Offset(1, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.exerciseName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
