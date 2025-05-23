import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskService {
  static const String _tasksKey = 'tasks';

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString(_tasksKey);
    if (tasksJson == null) return [];
    final List<dynamic> tasksList = jsonDecode(tasksJson);
    return tasksList.map((e) => Task.fromMap(e)).toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(tasks.map((e) => e.toMap()).toList());
    await prefs.setString(_tasksKey, tasksJson);
  }
}
