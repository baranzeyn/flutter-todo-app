import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/add_new_task_date_time.dart';
import 'package:todo_app/category.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/todo_service.dart';

import '../model/task.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key, required this.addNewTask})
      : super(key: key);
  final void Function(Task newTask) addNewTask;
  //Passing function as parameter

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  TodoService todoService = TodoService();

  TaskType taskType = TaskType.notes;

  void onCategorySelected(TaskType selectedTaskType) {
    setState(() {
      taskType = selectedTaskType;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    List<String> imgPaths = [
      "lib/assets/images/category_1.png",
      "lib/assets/images/category_2.png",
      "lib/assets/images/category_3.png"
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: deviceWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "lib/assets/images/add_new_task_header.png"),
                      fit: BoxFit.cover),
                ),
                height: deviceHeight / 10,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); //stackteki en üsteki sayfayı yani şu anda bulunduğu sayfayı pop eder
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                        child: Text(
                      "Add new task",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21),
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text("Task Title"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Category"),
                    for (String imgPath in imgPaths)
                      CategoryWidget(
                        title: imgPath,
                        onCategorySelected: onCategorySelected,
                      ),
                  ],
                ),
              ),
              DateYearInput(
                dateController: userIdController,
                timeController: timeController,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text("Description"),
              ),
              SizedBox(
                height: 300,
                child: TextField(
                  controller: descriptionController,
                  expands: true, //yazdıkça genişleyebilmesini istiyorum
                  maxLines: null,
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.white, isDense: true),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    saveTodo();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    //alınan inputlara göre bir todo oluşturmak
    Todo newTodo = Todo(
        id: -1,
        todo: titleController.text,
        completed: false,
        userId: int.parse(userIdController.text));
    todoService.addTodo(newTodo);
  }
}
