import 'package:app/main.dart';
import 'package:app/model/model_task.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class TaskEditor extends StatefulWidget {
  TaskEditor({this.task, Key? key}) : super(key: key);
  Task? task;
  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _taskTile = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _taskNote = TextEditingController(
        text: widget.task == null ? null : widget.task!.note!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(widget.task == null ? "Add a new Task" : "Update Your Task",
            style: const TextStyle(color: Colors.black)),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          const Text(
            "Your Task's Tital",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: _taskTile,
            decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Your Task"),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Your Task's Notes",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 25,
            controller: _taskNote,
            decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Write Some Notes"),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: SizedBox(
                width: double.infinity,
                height: 60,
                //  color: Colors.blueAccent.shade700,
                child: RawMaterialButton(
                  onPressed: () async {
                    var newTask = Task(
                        title: _taskTile.text,
                        note: _taskTile.text,
                        creationDate: DateTime.now().toString(),
                        done: false);

                    Box<Task> taskbox = Hive.box<Task>("task");
                    if (widget.task != null) {
                      widget.task!.title = newTask.title;
                      widget.task!.title = newTask.title;
                      widget.task!.save();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    } else {
                      await taskbox.add(newTask);
                      MaterialPageRoute(builder: (context) => const HomePage());
                    }
                  },
                  fillColor: Colors.blueAccent.shade700,
                  child: Text(
                    widget.task == null ? "Add new Task" : "Update Task",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
