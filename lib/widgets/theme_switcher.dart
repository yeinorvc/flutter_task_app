import 'package:flutter/material.dart';

class ThemeSwitcher extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onToggle;

  const ThemeSwitcher({
    Key? key,
    required this.isDarkMode,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
      onPressed: () => onToggle(!isDarkMode),
    );
  }
}
