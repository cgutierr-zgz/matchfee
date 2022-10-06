import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text.rich(
        TextSpan(
          text: 'Conff',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 30,
          ),
          children: [
            TextSpan(
              text: 'eeg',
              style: TextStyle(
                color: theme.colorScheme.secondary,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
