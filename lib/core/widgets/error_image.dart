import 'package:flutter/material.dart';

/// An error image widget so that we don't have to write the same asset
/// It has a square constructor if your dont want to pass both height and width
class ErrorImage extends StatelessWidget {
  const ErrorImage({
    super.key,
    required this.width,
    required this.height,
  });

  const ErrorImage.square({
    super.key,
    required double size,
  })  : height = size,
        width = size;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/error.png',
      height: height,
      width: width,
    );
  }
}
