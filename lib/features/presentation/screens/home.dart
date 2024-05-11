import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_spirit/features/data/api/models/collection_server.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/domain/sqlite/cubit/exercise_lite_cubit.dart';
import 'package:sport_spirit/features/domain/sqlite/cubit/home_cubit.dart';
import 'package:sport_spirit/features/presentation/screens/box_exercise.dart';
import 'package:sport_spirit/features/presentation/widjets/collection_exercises.dart';
import 'package:sport_spirit/features/presentation/widjets/training.dart';

class Home extends StatefulWidget {
  Home({super.key});

  final blocHome = service<HomeCubit>()..getValueKey();

  final blocExercise = service<ExercisesLiteCubit>();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Тренировки',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.format_list_bulleted_rounded),
              onPressed: () {
                context.pushNamed('list_exercises');
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.pushNamed('settings');
            },
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          bloc: widget.blocHome,
          builder: (context, state) {
            if (state is HomeInitial) {
            } else if (state is HomeNaN) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.goNamed('list_exercises');
              });
            } else if (state is HomeLoaded) {
              final data = state.data;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CollectionExercisesWidget(
                      collectionServer: CollectionServer(
                        collectionServerName: data.collectionName,
                        collectionServerType: data.collectionType,
                        collectionServerMultiplicity:
                            data.collectionMultiplicity,
                        availabilityBasicEquipment:
                            data.availabilityBasicEquipment,
                        genderId: data.genderName == 'М' ? 1 : 0,
                      ),
                      appVisibulity: false,
                      appVisibulityServer: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FilledButton(
                      onPressed: () => context.pushNamed('handbook'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'СПРАВОЧНИК',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.5),
                      ),
                    ),
                  ),
                  BlocBuilder<ExercisesLiteCubit, ExercisesLiteState>(
                    bloc: service<ExercisesLiteCubit>()
                      ..createListBoxExercixes(data.id!),
                    builder: (context, state) {
                      if (state is ExerciseLiteInitial) {}
                      if (state is ExerciseLiteListBoxLoaded) {
                        return Flexible(
                          child: ListView.builder(
                            itemCount: state.boxExercises.length,
                            itemBuilder: (context, index) {
                              final item = state.boxExercises[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BoxExercise(
                                        boxExercises: item,
                                        number: index,
                                      ),
                                    ),
                                  );
                                },
                                child: TrainingWidjet(
                                  boxExercises: item,
                                  index: ++index,
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              );
            } else if (state is HomeError) {
              Center(
                child: Text(
                  state.ex.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
