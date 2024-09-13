import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/locale_provider.dart';

class LanguageListTile extends StatelessWidget {
  const LanguageListTile({
    required this.name,
    required this.code,
    super.key,
  });

  final String name;
  final String code;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      onTap: () => context.read<LocaleProvider>().setLocale(code),
    );
  }
}
