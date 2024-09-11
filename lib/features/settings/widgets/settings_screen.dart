import 'package:flutter/material.dart';
import 'package:todo_app/extensions/build_context_x.dart';
import 'package:todo_app/features/settings/widgets/language_list_tile.dart';
import 'package:todo_app/features/settings/widgets/theme_preview_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.settingsScreenTitle,
          style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.themesListTitle,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 12),
              ThemePreviewItem.light(context),
              const SizedBox(height: 12),
              ThemePreviewItem.dark(context),
              const SizedBox(height: 12),
              Text(
                context.l10n.languagesListTitle,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 12),
              const LanguageListTile(name: 'English', code: 'en'),
              const LanguageListTile(name: 'Русский', code: 'ru'),
            ],
          ),
        ),
      ),
    );
  }
}
