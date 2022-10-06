import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

class MatchesAppBar extends StatelessWidget {
  const MatchesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SliverAppBar(
      foregroundColor: Colors.black,
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      title: Icon(
        Icons.forum_rounded,
        size: 50,
        color: theme.colorScheme.secondary,
      ),
    );
  }
}
