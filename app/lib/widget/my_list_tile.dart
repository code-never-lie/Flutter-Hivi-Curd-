import 'package:app/model/model_task.dart';
import 'package:app/screen/task_edit.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyListTile extends StatefulWidget {
  MyListTile({required this.task, index, Key? key}) : super(key: key);
  Task task;
  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
                child: Text(
              widget.task.title!,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskEditor(task: widget.task)));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  widget.task.delete();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
        const Divider(
          color: Colors.black87,
          height: 20,
          thickness: 1.0,
        ),
        Text(
          widget.task.note!,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        )
      ]),
    );
  }
}
