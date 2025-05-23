import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;

  const MyApp({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void _toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(onThemeChanged: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}
