import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

class MatchesAppBar extends StatelessWidget {
  const MatchesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SliverAppBar(
      foregroundColor: Colors.black, // !
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      title: const Icon(
        Icons.forum_rounded,
        size: 50,
        // TODO(c): find a good color for the (fee)
        color: Color(0xff6f4e37), //brown.shade400,
      ),
    );
  }
}
