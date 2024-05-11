import 'package:flutter/material.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/data/sqlite/models/local_collection_lite.dart';
import 'package:sport_spirit/features/domain/api/cubit/collection_server_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_spirit/features/domain/api/cubit/exercises_cubit.dart';
import 'package:sport_spirit/features/domain/sqlite/cubit/collection_lite_cubit.dart';
import 'package:sport_spirit/features/domain/sqlite/cubit/exercise_lite_cubit.dart';
import 'package:sport_spirit/features/presentation/widjets/collection_exercises.dart';
import 'package:sport_spirit/features/utils/router/getrouters.dart';
import '../../data/api/models/collection_server.dart';

class ListCollectionService extends StatefulWidget {
  const ListCollectionService({super.key});

  @override
  State<ListCollectionService> createState() => _ListCollectionServiceState();
}

class _ListCollectionServiceState extends State<ListCollectionService> {
  late TextEditingController pageController;
  late TextEditingController pageSizeController;
  bool _isExpanded = false;
  int gender = 0;
  bool isMaleSwitchOn = false, isFemaleSwitchOn = false;
  int id = 0;

  @override
  void initState() {
    super.initState();
    pageController = TextEditingController();
    pageSizeController = TextEditingController();
  }

  @override
  void dispose() {
    pageController.dispose();
    pageSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubitCollection = service<CollectionServerCubit>()
      ..getAllCollectionServer(
          page: pageController.text,
          pageSize: pageSizeController.text,
          gender: gender,
          logic: false);
    final cubitExercises = service<ExercisesCubit>();
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Выберите программу',
            textAlign: TextAlign.justify,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CollectionServerCubit, CollectionServerState>(
          bloc: cubitCollection,
          builder: (context, state) {
            if (state is CollectionServerInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CollectionServerLoaded) {
              final List<CollectionServer> data = state.data;
              return BlocBuilder<ExercisesCubit, ExercisesState>(
                bloc: cubitExercises,
                builder: (context, state) {
                  return Column(
                    children: [
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        firstChild: ListTile(
                          title: Text(gender == 1
                              ? 'Мужчины'
                              : gender == 2
                                  ? 'Женщины'
                                  : 'Без фильтрации'),
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          trailing: _isExpanded
                              ? const Icon(Icons.expand_less)
                              : const Icon(Icons.expand_more),
                        ),
                        secondChild: InkWell(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(68, 189, 185, 185),
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Row(
                                    children: [
                                      const Text('Мужчины'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Switch(
                                        value: isMaleSwitchOn,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value) {
                                              isMaleSwitchOn = true;
                                              isFemaleSwitchOn = false;
                                              gender = 1;
                                            } else {
                                              isMaleSwitchOn = false;
                                              gender = 0;
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Row(
                                    children: [
                                      const Text('Женщины'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Switch(
                                        value: isFemaleSwitchOn,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value) {
                                              isMaleSwitchOn = false;
                                              isFemaleSwitchOn = true;
                                              gender = 2;
                                            } else {
                                              isFemaleSwitchOn = false;
                                              gender = 0;
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 80.0, left: 30),
                                  child: TextFormField(
                                    controller: pageController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Страницы',
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        pageController.text =
                                            pageController.text;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 80.0, left: 30, bottom: 20),
                                  child: TextFormField(
                                    controller: pageSizeController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Кол-во программ',
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        pageSizeController.text =
                                            pageSizeController.text;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 80.0, left: 30, bottom: 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        pageController.text = '';
                                        pageSizeController.text = '';
                                        gender = 0;
                                        isMaleSwitchOn = false;
                                        isFemaleSwitchOn = false;
                                      });
                                    },
                                    child: const Text('Очистить фильтр'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        crossFadeState: _isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                      ),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            id = item.idCollectionServer!;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: InkWell(
                                onTap: () async {
                                  try {
                                    await service<CollectionLiteCubit>()
                                        .insertCollectionLite(
                                      CollectionLite(
                                        id: null,
                                        collectionName:
                                            item.collectionServerName,
                                        collectionType:
                                            item.collectionServerType,
                                        collectionMultiplicity:
                                            item.collectionServerMultiplicity,
                                        availabilityBasicEquipment:
                                            item.availabilityBasicEquipment,
                                        genderName:
                                            item.genderId == 1 ? 'М' : 'Ж',
                                      ),
                                    );

                                    await Future.delayed(Duration
                                        .zero); // Ensure the previous async operation is completed before continuing

                                    service<ExercisesLiteCubit>()
                                        .selectInsertExercises(
                                            page: 0,
                                            pageSize: 0,
                                            collectionId:
                                                item.idCollectionServer!);
                                    router.pop();
                                  } catch (e) {
                                    // Handle the error appropriately
                                    print('An error occurred: $e');
                                  }
                                },
                                child: CollectionExercisesWidget(
                                  collectionServer: item,
                                  appVisibulity: false,
                                  appVisibulityServer: false,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
