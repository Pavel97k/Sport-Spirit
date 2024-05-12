import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:SportSpirit/features/data/global_service.dart';
import 'package:SportSpirit/features/data/sqlite/models/local_exercises_lite.dart';
import 'package:SportSpirit/features/domain/api/cubit/exercise_criterions_cubit.dart';

class ExerciseInfo extends StatefulWidget {
  final ExercisesLite boxExercises;
  final int idCriterions;
  final bool isHandbook;
  const ExerciseInfo(
      {super.key,
      required this.boxExercises,
      required this.idCriterions,
      required this.isHandbook});

  @override
  State<ExerciseInfo> createState() => _ExerciseInfoState();
}

class _ExerciseInfoState extends State<ExerciseInfo> {
  bool isButtonEnabledStop = true;
  bool isButtonEnabledPause = true;
  bool isButtonEnabledStart = true;
  bool isTimerRunning = false;
  bool isExerciseComplete = false;
  late Timer _timer;
  int seconds = 0;
  int minute = 0;
  int targetSec = 0;
  int targetMin = 0;
  bool isPaused = false;
  bool isStopped = true;
  int approaches = 0;
  int repetition = 0;

  late TextEditingController repetitionController;

  @override
  void initState() {
    super.initState();
    repetitionController = TextEditingController();
  }

  @override
  void dispose() {
    repetitionController.dispose();
    super.dispose();
  }

  void startTimer(int targetMinute, int targetSeconds) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      targetMin = targetMinute;
      targetSec = targetSeconds;
      setState(() {
        if (seconds < targetSeconds || minute < targetMinute) {
          seconds++;
          if (seconds == 60) {
            seconds = 0;
            minute++;
          }
        } else {
          _timer.cancel();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Упражнение завершено'),
                actions: [
                  TextButton(
                    child: const Text('Ок'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    });
  }

  void pauseTimer() {
    setState(() {
      if (isPaused) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            if (seconds < targetSec && targetMin < targetMin) {
              seconds++;
              if (seconds == 60) {
                seconds = 0;
                minute++;
              }
            } else {
              _timer.cancel();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Упражнение завершено'),
                    actions: [
                      TextButton(
                        child: const Text('Ок'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          });
        });
        isPaused = false;
      } else {
        _timer.cancel();
        isPaused = true;
      }
    });
  }

  void stopTimer() {
    setState(() {
      _timer.cancel();
      seconds = 0;
      minute = 0;
      isPaused = false;
      isStopped = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = service<ExerciseCriterionsCubit>()
      ..getIdExerciseCriterios(widget.idCriterions);

    return SafeArea(
      top: false,
      child: Scaffold(
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            collapsedHeight: 240,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                //"https://www.powertrafic.fr/wp-content/uploads/2023/04/image-ia-exemple.png",
                //'assets/images/krolic.gif',
                widget.isHandbook
                    ? 'https://media1.tenor.com/m/Pt61JKPbTV0AAAAC/ryan-work-out.gif'
                    : 'https://media1.tenor.com/m/x2OqSGySCmEAAAAC/gym-life.gif',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Text(
                                  widget.boxExercises.exerciseName,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.boxExercises.exerciseDescriptions !=
                                          null
                                      ? widget
                                          .boxExercises.exerciseDescriptions!
                                      : widget.isHandbook
                                          ? 'Упражнение без описания выполнения'
                                          : 'Описание нету, так что думай сам)',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.boxExercises.muscleGroup,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.isHandbook ? false : true,
                    child: BlocBuilder<ExerciseCriterionsCubit,
                        ExerciseCriterionsState>(
                      bloc: bloc,
                      builder: (context, state) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (state is ExerciseCriterionsTimeLoaded) ...{
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Время \nвыполнения',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      state.timeList.length >= 2
                                          ? state.timeList[1]
                                              .toString()
                                              .padLeft(2, '0')
                                          : '0',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      ':',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      state.timeList.length >= 3
                                          ? state.timeList[2]
                                              .toString()
                                              .padLeft(2, '0')
                                          : '0',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Прошедшее \nвремя',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      minute.toString().padLeft(2, '0'),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      ':',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      seconds.toString().padLeft(2, '0'),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  FilledButton(
                                    onPressed: isButtonEnabledStop
                                        ? () {
                                            isButtonEnabledStop = false;
                                            isButtonEnabledStart = true;
                                            isButtonEnabledPause = false;
                                            setState(() {
                                              stopTimer();
                                            });
                                          }
                                        : null,
                                    style: const ButtonStyle(),
                                    child: const Icon(Icons.stop),
                                  ),
                                  FilledButton(
                                    onPressed: isButtonEnabledPause
                                        ? () {
                                            isButtonEnabledPause = false;
                                            isButtonEnabledStop = true;
                                            isButtonEnabledStart = true;
                                            setState(() {
                                              pauseTimer();
                                            });
                                          }
                                        : null,
                                    style: const ButtonStyle(),
                                    child: const Icon(Icons.pause),
                                  ),
                                  FilledButton(
                                    onPressed: isButtonEnabledStart
                                        ? () {
                                            isButtonEnabledStart = false;
                                            isButtonEnabledPause = true;
                                            isButtonEnabledStop = true;
                                            setState(() {
                                              startTimer(state.timeList[1],
                                                  state.timeList[2]);
                                              isStopped = false;
                                            });
                                          }
                                        : null,
                                    style: const ButtonStyle(),
                                    child: const Icon(Icons.play_arrow),
                                  ),
                                ],
                              ),
                            } else if (state
                                is ExerciseCriterionsRepetitionLoaded) ...{
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Повторений:',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      state.data.repetition.toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'Подходов:',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      state.data.approaches.toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Выполнено\nповторений:',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      repetition.toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'Выполнено\nподходов:',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      approaches.toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: SizedBox(
                                          width: 160,
                                          child: TextFormField(
                                            controller: repetitionController,
                                            onEditingComplete: () {
                                              setState(() {
                                                final number =
                                                    repetitionController.text;
                                                repetition += int.parse(number);
                                                if (repetition >=
                                                    state.data.repetition!) {
                                                  approaches++;
                                                  repetition = 0;
                                                }
                                                if (approaches >=
                                                    state.data.approaches!) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Упражнение завершено'),
                                                        actions: [
                                                          TextButton(
                                                            child: const Text(
                                                                'Ок'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              labelText: 'Ваши повторения',
                                              filled: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: FilledButton(
                                      onPressed: isButtonEnabledStop
                                          ? () {
                                              setState(() {
                                                repetition = 0;
                                                approaches = 0;
                                                repetitionController.clear();
                                              });
                                            }
                                          : null,
                                      child: const Icon(Icons.stop),
                                    ),
                                  ),
                                ],
                              ),
                            },
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }, childCount: 1),
          ),
        ]),
      ),
    );
  }
}
