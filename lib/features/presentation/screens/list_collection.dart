import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_spirit/features/data/api/models/collection_server.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/domain/sqlite/cubit/collection_lite_cubit.dart';
import 'package:sport_spirit/features/presentation/widjets/collection_exercises.dart';
import 'package:sport_spirit/features/utils/storage/shared_preferences_helper.dart';

class ListExercises extends StatefulWidget {
  const ListExercises({super.key});

  @override
  State<ListExercises> createState() => _ListExercisesState();
}

class _ListExercisesState extends State<ListExercises> {
  late TextEditingController pageController;
  late TextEditingController pageSizeController;
  bool _isExpanded = false;
  int page = 0, pageSize = 0, gender = 0;
  bool isMaleSwitchOn = false, isFemaleSwitchOn = false;

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
    final bloc = service<CollectionLiteCubit>()
      ..getAllCollectionLite(
          page: pageController.text,
          pageSize: pageSizeController.text,
          gender: gender);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Мои программы',
            textAlign: TextAlign.justify,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          leading: null,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pushNamed('list_exercises_service');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'ВЫБРАТЬ ГОТОВУЮ ТРЕНИРОВКУ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 5),
            const SizedBox(height: 10),
            BlocBuilder<CollectionLiteCubit, CollectionLiteState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is CollectionLiteInitial) {
                  return const Center(
                    child: Column(children: [
                      Icon(Icons.list_alt),
                      Text(
                        'Выбранный программ нет)',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ]),
                  );
                } else if (state is CollectionLiteListLoaded) {
                  final items = state.data;
                  return Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(68, 189, 185, 185),
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
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                child: InkWell(
                                  onTap: () {
                                    service<SharedPreferencesHelper>()
                                        .setInt('Active_program', item.id!);
                                    context.goNamed('home');
                                  },
                                  child: CollectionExercisesWidget(
                                    collectionServer: CollectionServer(
                                        idCollectionServer: item.id,
                                        collectionServerName:
                                            item.collectionName,
                                        collectionServerType:
                                            item.collectionType,
                                        collectionServerMultiplicity:
                                            item.collectionMultiplicity,
                                        availabilityBasicEquipment:
                                            item.availabilityBasicEquipment,
                                        genderId:
                                            item.genderName == 'М' ? 1 : 0),
                                    appVisibulity:
                                        item.id == state.id ? true : false,
                                    appVisibulityServer: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is CollectionLiteError) {
                  return const Center(
                    child: Column(children: [
                      Text(
                        '\u{1F643}',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        'Не удалось получить данные -_-',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ]),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
