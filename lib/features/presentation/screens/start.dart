import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_tutorial.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Sport Spirit',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.orange.shade600,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      shadows: const <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 5.0,
                          color: Color.fromARGB(255, 65, 64, 64),
                        ),
                        Shadow(
                          offset: Offset(8.0, 2.0),
                          blurRadius: 12.0,
                          color: Color.fromARGB(123, 0, 0, 0),
                        ),
                      ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 80.0),
                  child: FilledButton(
                      onPressed: () {
                        context.pushNamed('authorization');
                      },
                      style: FilledButton.styleFrom(
                        shape: LinearBorder.none,
                        padding: const EdgeInsets.all(12),
                      ),
                      child: const Text('Войти')),
                ),
                TextButton(
                    onPressed: () => context.goNamed('tutorial'),
                    style: FilledButton.styleFrom(
                      shape: LinearBorder.none,
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Text('Проупстить')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
