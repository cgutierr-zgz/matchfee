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
    return SliverToBoxAdapter(
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xff6f4e37),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).padded(),
    );
  }
}
