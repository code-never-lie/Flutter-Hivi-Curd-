import 'package:app/model/model_task.dart';
import 'package:app/screen/task_edit.dart';
import 'package:app/widget/my_list_tile.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("task");
  box.add(Task(
      title: "This Is My Habit App",
      note: "Ahmad Raza",
      creationDate: DateTime.now().toString()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "My Habit App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>("task").listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Today is My Task",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    formatDate(DateTime.now(), [d, "/", M, "/", yyyy]),
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 18.0),
                  ),
                  const Divider(
                    height: 40.0,
                    thickness: 1.0,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: box.values.length,
                          itemBuilder: (context, index) {
                            Task currentTask = box.getAt(index)!;
                            return MyListTile(
                              task: currentTask,
                              index: index,
                            );
                          }))
                ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskEditor()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
