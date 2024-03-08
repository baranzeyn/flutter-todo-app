import 'package:flutter/material.dart';
import 'package:todo_app/constants/tasktype.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key? key, required this.title, required this.taskType})
      : super(key: key);
  final String title;
  TaskType taskType;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          //alttan uyarı mesajı verebilmek için
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("Category selected"),
          ),
        );
        setState(() {
          widget.title == "lib/assets/images/category_1.png"
              ? widget.taskType = TaskType.notes
              : widget.title == "lib/assets/images/category_2.png"
                  ? widget.taskType = TaskType.calendar
                  : widget.taskType = TaskType.contest;
        });
      },
      child: Image.asset(widget.title),
    );
  }
}
