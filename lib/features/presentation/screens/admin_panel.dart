import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:SportSpirit/features/data/global_service.dart';
import 'package:SportSpirit/features/domain/api/cubit/collection_server_cubit.dart';

class AdminPanel extends StatefulWidget {
  final token;
  const AdminPanel({super.key, this.token});
  static int id = 0;

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final cubitCollection = service<CollectionServerCubit>()
    ..getAllCollectionServer(page: '0', pageSize: '0', gender: 0);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Панель Администратора',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Коллекции упр.'),
              // Add more tabs as needed
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (context) => CollectionServerCubit()
                ..getAllCollectionServer(page: '0', pageSize: '0', gender: 0),
              child: BlocBuilder<CollectionServerCubit, CollectionServerState>(
                bloc: cubitCollection,
                builder: (context, state) {
                  switch (state) {
                    case CollectionServerInitial _:
                      break;
                    case CollectionServerLoaded _:
                      return Column(children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Код')),
                                    DataColumn(label: Text('Название')),
                                    DataColumn(label: Text('Тип')),
                                    DataColumn(label: Text('Сложность')),
                                    DataColumn(label: Text('Оборудование')),
                                    DataColumn(label: Text('Пол')),
                                    DataColumn(label: Text('Доступен')),
                                  ],
                                  rows: state.data.map((e) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(
                                            e.idCollectionServer.toString())),
                                        DataCell(Text(e.collectionServerName)),
                                        DataCell(Text(e.collectionServerType)),
                                        DataCell(Text(
                                            e.collectionServerMultiplicity)),
                                        DataCell(Text(e
                                            .availabilityBasicEquipment
                                            .toString())),
                                        DataCell(
                                            Text(e.genderId == 1 ? 'М' : 'Ж')),
                                        DataCell(Text(e.isDeleted.toString())),
                                      ],
                                      onSelectChanged: (value) {
                                        if (value == true) {
                                          AdminPanel.id = e.idCollectionServer!;
                                        }
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 10), // Add a SizedBox for spacing
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FilledButton(
                              onPressed: () => service<CollectionServerCubit>()
                                  .deleteLogicCollectionServer(
                                      id: AdminPanel.id,
                                      token: widget.token.toString()),
                              style: FilledButton.styleFrom(
                                minimumSize: const Size(100, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'УДАЛИТЬ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2.5),
                              ),
                            ),
                            FilledButton(
                              onPressed: () => service<CollectionServerCubit>()
                                  .updateLogicCollectionServer(
                                      id: AdminPanel.id, token: widget.token),
                              style: FilledButton.styleFrom(
                                minimumSize: const Size(100, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'ВОССТАНОВИТЬ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2.5),
                              ),
                            ),
                          ],
                        ),
                      ]);
                    case CollectionServerError():
                      Center(
                        child: Text(state.error.toString()),
                      );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
