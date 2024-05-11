import 'package:flutter/material.dart';
import 'package:sport_spirit/features/data/api/models/collection_server.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/domain/sqlite/cubit/collection_lite_cubit.dart';
import 'package:sport_spirit/features/utils/storage/shared_preferences_helper.dart';

class CollectionExercisesWidget extends StatelessWidget {
  final CollectionServer collectionServer;
  final bool appVisibulity;
  final bool appVisibulityServer;
  const CollectionExercisesWidget(
      {super.key,
      required this.collectionServer,
      required this.appVisibulity,
      required this.appVisibulityServer});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 0.5,
            spreadRadius: 1.5,
            color: Colors.black26,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        border: Border.all(
            color: Colors.black54, style: BorderStyle.solid, width: 0.1),
        image: const DecorationImage(
          colorFilter: ColorFilter.srgbToLinearGamma(),
          image: AssetImage('assets/images/image 3.png'),
          opacity: 0.79,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: appVisibulity == true
                ? 33
                : appVisibulityServer == true
                    ? 33
                    : 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 60,
                ),
                Visibility(
                  visible: appVisibulity,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.amber,
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      child: Text("Активный"),
                    ),
                  ),
                ),
                Visibility(
                  visible: appVisibulityServer,
                  child: MenuAnchor(
                    style: MenuStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(10, 10),
                      ),
                    ),
                    builder: (BuildContext context, MenuController controller,
                        Widget? child) {
                      return IconButton(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.amberAccent,
                        ),
                        tooltip: 'Show menu',
                      );
                    },
                    menuChildren: List<MenuItemButton>.generate(
                      1,
                      (int index) => MenuItemButton(
                        onPressed: () async {
                          service<CollectionLiteCubit>().deleteCollectionLite(
                              collectionServer.idCollectionServer!);
                          final id = await service<SharedPreferencesHelper>()
                              .getInt('Active_program');

                          if (id == collectionServer.idCollectionServer) {
                            service<SharedPreferencesHelper>()
                                .deleteKey('Active_program');
                          }
                        },
                        child: const Text('Удалить'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 35,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    collectionServer.collectionServerName,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 35,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    collectionServer.collectionServerType,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
