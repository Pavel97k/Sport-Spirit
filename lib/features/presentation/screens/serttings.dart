import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_spirit/features/utils/theme/theme_data.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late bool selectedColorWhite = false;
  late bool selectedColorBlack = false;
  late bool selectedColorWhiteModOne = false;
  late bool selectedColorWhiteModTwo = false;
  late bool selectedColorWhiteModThree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Настройки',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Цветовая палитра',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 231, 102, 92),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ColorOption(
                    color: Colors.white,
                    isSelected: selectedColorWhite,
                    onTap: () {
                      selectedColorBlack = false;
                      selectedColorWhiteModOne = false;
                      selectedColorWhiteModTwo = false;
                      selectedColorWhiteModThree = false;
                      setState(() {
                        final provider =
                            Provider.of<ThemesData>(context, listen: false);
                        provider.swapTheme(0);
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 231, 102, 92),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ColorOption(
                    color: Colors.black,
                    isSelected: selectedColorBlack,
                    onTap: () {
                      selectedColorWhite = false;
                      selectedColorWhiteModOne = false;
                      selectedColorWhiteModTwo = false;
                      selectedColorWhiteModThree = false;
                      setState(() {
                        final provider =
                            Provider.of<ThemesData>(context, listen: false);
                        provider.swapTheme(1);
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 231, 102, 92),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ColorOption(
                    color: const Color.fromARGB(128, 36, 199, 30),
                    isSelected: selectedColorWhiteModOne,
                    onTap: () {
                      selectedColorWhite = false;
                      selectedColorBlack = false;
                      selectedColorWhiteModTwo = false;
                      selectedColorWhiteModThree = false;
                      setState(() {
                        final provider =
                            Provider.of<ThemesData>(context, listen: false);
                        provider.swapTheme(2);
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 231, 102, 92),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ColorOption(
                    color: const Color.fromARGB(128, 16, 134, 188),
                    isSelected: selectedColorWhiteModTwo,
                    onTap: () {
                      selectedColorWhite = false;
                      selectedColorBlack = false;
                      selectedColorWhiteModOne = false;
                      selectedColorWhiteModThree = false;
                      setState(() {
                        final provider =
                            Provider.of<ThemesData>(context, listen: false);
                        provider.swapTheme(3);
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 231, 102, 92),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ColorOption(
                    color: const Color.fromARGB(128, 198, 50, 193),
                    isSelected: selectedColorWhiteModThree,
                    onTap: () {
                      selectedColorWhite = false;
                      selectedColorBlack = false;
                      selectedColorWhiteModOne = false;
                      selectedColorWhiteModTwo = false;
                      setState(() {
                        final provider =
                            Provider.of<ThemesData>(context, listen: false);
                        provider.swapTheme(4);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorOption({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
