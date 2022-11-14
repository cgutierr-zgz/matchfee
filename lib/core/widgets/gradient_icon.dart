import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  const GradientIcon({
    super.key,
    required this.icon,
    required this.size,
    this.gradient,
  });

  final IconData icon;
  final double size;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final shaderGradient = gradient ??
        const LinearGradient(
          colors: [
            Colors.grey,
            Colors.grey,
          ],
        );

    return ShaderMask(
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          icon,
          size: size * 0.8,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final rect = Rect.fromLTRB(0, 0, size, size);

        return shaderGradient.createShader(rect);
      },
    );
  }
}
