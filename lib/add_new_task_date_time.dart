import 'package:flutter/material.dart';

import 'inputfield.dart';

class DateYearInput extends StatelessWidget {
  final TextEditingController dateController;
  final TextEditingController timeController;

  DateYearInput({
    required this.dateController,
    required this.timeController,
  });

  Map<String, String> getInputValues() {
    return {
      'date': dateController.text,
      'time': timeController.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: InputField(
              label: "Date",
              controller: dateController,
            ),
          ),
          Expanded(
            child: InputField(
              label: "Time",
              controller: timeController,
            ),
          ),
        ],
      ),
    );
  }
}