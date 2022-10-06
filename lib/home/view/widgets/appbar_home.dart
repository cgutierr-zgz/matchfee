import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.settings),
      ),
      centerTitle: true,
      title: const _AppBarTitle(),
      actions: [
        IconButton(
          onPressed: () => context.push(const MatchesPage()),
          icon: const Icon(Icons.chat_bubble),
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
