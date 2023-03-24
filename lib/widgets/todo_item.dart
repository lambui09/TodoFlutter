import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onToDoDelete;

  const ToDoItem({super.key, required this.todo, required this.onToDoChange, required this.onToDoDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25, ),
      child: ListTile(
        onTap: onToDoChange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box_rounded : Icons.check_box_outline_blank,
          color: tdBlue,
          size: 30,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            decoration: todo.isDone?  TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          color: tdRed,
          iconSize: 25,
          icon: const Icon(Icons.delete_outlined),
          onPressed: onToDoDelete,
        ),
      ),
    );
  }
}