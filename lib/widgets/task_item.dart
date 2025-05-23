import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(String) onEdit;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  void _showEditDialog(BuildContext context) {
    final controller = TextEditingController(text: task.title);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Editar Tarea'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: 'Título'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onEdit(controller.text);
              Navigator.of(context).pop();
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (_) => onToggle(),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _showEditDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
