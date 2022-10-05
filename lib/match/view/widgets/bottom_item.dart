import 'package:flutter/material.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({
    super.key,
    required this.icon,
    required this.size,
    required this.color,
    this.onPressed,
  }) : assert(size >= 50, 'Size must be greater than 50');

  final IconData icon;
  final double size;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: onPressed,
        shape: const CircleBorder(),
        child: Icon(
          icon,
          size: size - 30,
          color: color,
        ),
      ),
    );
  }
}
