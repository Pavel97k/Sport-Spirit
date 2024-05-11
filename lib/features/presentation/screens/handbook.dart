import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HandBook extends StatelessWidget {
  const HandBook({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Справочник',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: null,
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              child: InkWell(
                onTap: () {
                  context.pushNamed('handbook_info');
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
                  child: const Center(
                    child: ListTile(
                      trailing: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.black,
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Упражнения',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
        ),
      ),
    );
  }
}
