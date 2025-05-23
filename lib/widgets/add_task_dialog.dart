import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(String) onAdd;

  const AddTaskDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _controller = TextEditingController();

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onAdd(text);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nueva Tarea'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(hintText: 'Escribe la tarea'),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: _submit,
          child: Text('Añadir'),
        ),
      ],
    );
  }
}
