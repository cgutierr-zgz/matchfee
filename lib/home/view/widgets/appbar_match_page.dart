import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class AppBarMatchPage extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMatchPage({super.key});

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
        // TODO(carlos): add appbar icon theme + theme in general
        icon: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
      ),
      centerTitle: true,
      title: const _AppBarTitle(),
      actions: [
        IconButton(
          onPressed: () => context.push(const MatchesPage()),
          icon: const Icon(
            Icons.chat_bubble,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
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
            children: const [
              TextSpan(
                text: 'Fee',
                style: TextStyle(
                  // TODO(c): find a good color for the (fee)
                  color: Color(0xff6f4e37), //brown.shade400,
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
