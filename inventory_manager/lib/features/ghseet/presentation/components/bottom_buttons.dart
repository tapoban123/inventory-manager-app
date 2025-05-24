import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final String addNewButtonTitle;
  final VoidCallback addNewCallback;
  final VoidCallback onSaveCallback;

  const BottomButtons({
    super.key,
    required this.addNewButtonTitle,
    required this.addNewCallback,
    required this.onSaveCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.indigo,
              ),
              onPressed: onSaveCallback,
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 5),

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.amber,
              ),
              onPressed: addNewCallback,
              child: Text(
                addNewButtonTitle,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
