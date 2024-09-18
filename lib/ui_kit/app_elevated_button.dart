import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.icon,
    required this.color,
    required this.onPressed,
    this.disabled = false,
    super.key,
  });

  final Icon icon;
  final Color color;
  final VoidCallback onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(const CircleBorder()),
        padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
        backgroundColor: WidgetStateProperty.all(disabled ? Colors.grey : color),
      ),
      child: icon,
    );
  }
}
