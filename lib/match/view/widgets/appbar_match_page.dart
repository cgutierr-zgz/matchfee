import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

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
      title: const AppBarTitle(),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.chat_bubble,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo.png', height: 30, width: 30),
        const Text.rich(
          TextSpan(
            text: 'Match',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 30,
            ),
            children: [
              TextSpan(
                text: 'Fee',
                style: TextStyle(
                  // TODO(c): find a good color for the (fee)
                  color: Colors.red, //brown.shade400,
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
