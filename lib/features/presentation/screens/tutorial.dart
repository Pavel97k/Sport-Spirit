import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Tutorial extends StatelessWidget {
  const Tutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: IntroductionScreen(
          showBackButton: true,
          back: const Icon(Icons.arrow_circle_left_outlined),
          next: const Icon(Icons.arrow_circle_right_outlined),
          done: const Icon(Icons.done),
          onDone: () => context.goNamed('home'),
          pages: [
            PageViewModel(
              title: 'Тренируйся дома или в спортзале',
              body:
                  'Худей, набирай массу, качай ягодицы, становись рельефнее по готовым программам с диетой.',
              image: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/images/home_tutorial.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(85.0, 90.0, 0.0, 0.0),
                    child: SizedBox(
                      child: Image.asset(
                        'assets/images/zal_tutorial.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PageViewModel(
              title: 'Создай свою тренировку',
              body:
                  'Составь тренировачный план самостоятельно из нашей большой базы упражнений.',
              image: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/images/phone_tutorial.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
