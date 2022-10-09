import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/settings/settings.dart';

class CoffeesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoffeesAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<MatchesPage>(
            builder: (_) => const SettingsPage(),
          ),
        ),
        icon: const Icon(Icons.settings_rounded),
      ),
      centerTitle: true,
      title: const _AppBarTitle(),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<MatchesPage>(
              builder: (_) => const MatchesPage(),
            ),
          ),
          icon: const Icon(Icons.chat_bubble_rounded),
        ),
      ],
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo.png', height: 30, width: 30),
        Text.rich(
          TextSpan(
            text: 'Match',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 30,
            ),
            children: [
              TextSpan(
                text: 'Fee',
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ].joinWith(const SizedBox(width: 10)),
    );
  }
}
