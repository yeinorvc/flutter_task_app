import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/task_item.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/theme_switcher.dart';

enum Filter { all, pending, completed }

class HomeScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const HomeScreen({Key? key, required this.onThemeChanged, required this.isDarkMode}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];
  Filter _filter = Filter.all;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _taskService.loadTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _saveTasks() async {
    await _taskService.saveTasks(_tasks);
  }

  void _addTask(String title) {
    final newTask = Task(id: DateTime.now().toString(), title: title);
    setState(() {
      _tasks.add(newTask);
    });
    _saveTasks();
  }

  void _editTask(Task task, String newTitle) {
    setState(() {
      task.title = newTitle;
    });
    _saveTasks();
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
    _saveTasks();
  }

  void _toggleCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
    _saveTasks();
  }

  List<Task> get _filteredTasks {
    switch (_filter) {
      case Filter.pending:
        return _tasks.where((task) => !task.isCompleted).toList();
      case Filter.completed:
        return _tasks.where((task) => task.isCompleted).toList();
      case Filter.all:
      default:
        return _tasks;
    }
  }

  void _changeFilter(Filter filter) {
    setState(() {
      _filter = filter;
    });
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (_) => AddTaskDialog(
        onAdd: _addTask,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas Diarias'),
        actions: [
          ThemeSwitcher(
            isDarkMode: widget.isDarkMode,
            onToggle: widget.onThemeChanged,
          ),
        ],
      ),
      body: Column(
        children: [
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              FilterChip(
                label: Text('Todas'),
                selected: _filter == Filter.all,
                onSelected: (_) => _changeFilter(Filter.all),
              ),
              FilterChip(
                label: Text('Pendientes'),
                selected: _filter == Filter.pending,
                onSelected: (_) => _changeFilter(Filter.pending),
              ),
              FilterChip(
                label: Text('Completadas'),
                selected: _filter == Filter.completed,
                onSelected: (_) => _changeFilter(Filter.completed),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTasks.length,
              itemBuilder: (_, index) {
                final task = _filteredTasks[index];
                return TaskItem(
                  task: task,
                  onToggle: () => _toggleCompletion(task),
                  onDelete: () => _deleteTask(task),
                  onEdit: (newTitle) => _editTask(task, newTitle),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
