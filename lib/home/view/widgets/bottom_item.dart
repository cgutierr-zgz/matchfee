import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BottomItem extends StatefulWidget {
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
  State<BottomItem> createState() => _BottomItemState();
}

class _BottomItemState extends State<BottomItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void playAnimation() => animationController.forward(from: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
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
        height: widget.size,
        onPressed: () {
          playAnimation();
          widget.onPressed?.call();
        },
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
        child: Icon(
          widget.icon,
          size: widget.size - 20,
          color: widget.color,
        ),
      ),
    )
        .animate(
          controller: animationController,
          adapter: ValueAdapter(1),
        )
        .scale(begin: 0.8, end: 1);
  }
}
