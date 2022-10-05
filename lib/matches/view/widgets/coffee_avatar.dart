import 'package:flutter/material.dart';

class CoffeeAvatar extends StatelessWidget {
  const CoffeeAvatar({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Image.asset(
        imagePath,
        height: 75,
        width: 75,
        fit: BoxFit.cover,
      ),
    );
  }
}
