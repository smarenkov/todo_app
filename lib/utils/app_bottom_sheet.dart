// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

class AppBottomSheet {
  static Future<dynamic> showDefaultModalBottomSheet({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: builder,
    );
  }
}
