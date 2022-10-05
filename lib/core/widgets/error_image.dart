import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/error.png',
      height: size,
      width: size,
    );
  }
}
