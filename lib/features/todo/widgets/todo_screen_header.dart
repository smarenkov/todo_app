import 'package:flutter/material.dart';

class TodoScreenHeader extends StatelessWidget {
  const TodoScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        'Inbox tasks',
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
          fontSize: 36,
        ),
      ),
    );
  }
}
