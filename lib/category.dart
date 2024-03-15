import 'package:flutter/material.dart';
import 'package:todo_app/constants/tasktype.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget(
      {Key? key, required this.title, required this.onCategorySelected})
      : super(key: key);
  final String title;
  final Function(TaskType) onCategorySelected;
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
        TaskType selectedTaskType;
        widget.title == "lib/assets/images/category_1.png"
            ? selectedTaskType = TaskType.notes
            : widget.title == "lib/assets/images/category_3.png"
                ? selectedTaskType = TaskType.calendar
                : selectedTaskType = TaskType.contest;
        widget.onCategorySelected(selectedTaskType);
      },
      child: Image.asset(widget.title),
    );
  }
}
