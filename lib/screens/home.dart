import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/header.dart';
import 'package:todo_app/screens/add_new_task.dart';
import 'package:todo_app/service/todo_service.dart';
import 'package:todo_app/todoitem.dart';

import '../constants/color.dart';
import '../model/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> todo = [
    Task(
        title: "Study Lessons",
        type: TaskType.notes,
        description: "StudyComp117",
        isCompleted: false),
    Task(
        title: "Run 5K",
        type: TaskType.contest,
        description: "Run 5 kilometers",
        isCompleted: false),
    Task(
        title: "Go to party",
        type: TaskType.calendar,
        description: "Attend to party",
        isCompleted: false)
  ];

  List<Task> completed = [
    Task(
        title: "Game meetup",
        type: TaskType.calendar,
        description: "Attend game meetup",
        isCompleted: false),
    Task(
        title: "Take out trash",
        type: TaskType.contest,
        description: "house cleaning",
        isCompleted: false)
  ];

  void addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();
    todoService.getUncompleted();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: HexColor(backgroundColor),
            body: Column(
              children: [
                //Header
                HeaderWidget(),
                //Top Column
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: SingleChildScrollView(
                      child: FutureBuilder(
                        future: todoService.getUncompleted(),
                        builder: (context, snapshot) {
                          print(snapshot.data);
                          if (snapshot.data == null) {
                            return const CircularProgressIndicator();
                          } else {
                            return ListView.builder(
                              primary:
                                  false, //scrollable olan ögenin SingleChildScrollView olmasını istediğimizden listviewdakini disable ettik
                              shrinkWrap:
                                  true, //bu olmazsa içinde bulunduğu tüm alanı almaya çalışır
                              itemCount: snapshot
                                  .data!.length, //null gelemezse bunu hesapla
                              itemBuilder: (context, index) {
                                return TodoItem(
                                  task: snapshot.data![index],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ), //completed text
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Completed",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                ),
                //Bottom Column

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: SingleChildScrollView(
                      child: FutureBuilder(
                        future: todoService.getCompleted(),
                        builder: (context, snapshot) {
                          print(snapshot.data);
                          if (snapshot.data == null) {
                            return const CircularProgressIndicator();
                          } else {
                            return ListView.builder(
                              primary:
                              false, //scrollable olan ögenin SingleChildScrollView olmasını istediğimizden listviewdakini disable ettik
                              shrinkWrap:
                              true, //bu olmazsa içinde bulunduğu tüm alanı almaya çalışır
                              itemCount: snapshot
                                  .data!.length, //null gelemezse bunu hesapla
                              itemBuilder: (context, index) {
                                return TodoItem(
                                  task: snapshot.data![index],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),

                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddNewTaskScreen(
                          addNewTask: (newTask) => addNewTask(newTask),
                        ),
                      ));
                    },
                    child: const Text("Add new task"))
              ],
            ),
          ),
        ));
  }
}
