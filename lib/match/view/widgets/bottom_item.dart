import 'package:flutter/material.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
  }) : size = 70;

  const BottomItem.small({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
  }) : size = 50;

  final IconData icon;
  final double size;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
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
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
        child: Icon(
          icon,
          size: size - 20,
          color: color,
        ),
      ),
    );
  }
}
