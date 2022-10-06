import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

class InfoTitle extends StatelessWidget {
  const InfoTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SliverToBoxAdapter(
      child: Text(
        text,
        style: TextStyle(
          color: theme.colorScheme.secondary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).padded(),
    );
  }
}
