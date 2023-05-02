import 'package:flutter/material.dart';

class CreateTaskButton extends StatelessWidget {
  const CreateTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      child: const Icon(Icons.add),
    );
  }
}
