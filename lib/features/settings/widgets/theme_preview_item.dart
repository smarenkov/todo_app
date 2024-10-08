import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/extensions/build_context_x.dart';
import 'package:todo_app/shared/theme_provider.dart';
import 'package:todo_app/theme/theme_type.dart';

class ThemePreviewItem extends StatelessWidget {
  const ThemePreviewItem({
    required this.name,
    required this.description,
    required this.type,
    super.key,
  });

  final String name;
  final String description;
  final ThemeType type;

  factory ThemePreviewItem.light(BuildContext context) {
    return ThemePreviewItem(
      name: context.l10n.lightThemeName,
      description: context.l10n.lightThemeDescription,
      type: ThemeType.light,
    );
  }

  factory ThemePreviewItem.dark(BuildContext context) {
    return ThemePreviewItem(
      name: context.l10n.darkThemeName,
      description: context.l10n.darkThemeDescription,
      type: ThemeType.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ThemeProvider>().setTheme(type),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: type.theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: type.theme.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: type.theme.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),
                Text(
                  description,
                  style: type.theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Opacity(
                opacity: _showCheckIcon(type, context) ? 1 : 0,
                child: Icon(
                  Icons.check,
                  color: type.theme.iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _showCheckIcon(ThemeType themeType, BuildContext context) {
    return type.theme == context.watch<ThemeProvider>().theme;
  }
}
