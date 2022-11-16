import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomAnimatedButton extends StatefulWidget {
  const CustomAnimatedButton({
    super.key,
    this.onPressed,
    required this.child,
    this.scale = true,
    this.rotate = false,
  });

  final void Function()? onPressed;
  final Widget child;
  final bool scale;
  final bool rotate;

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    animation = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed == null
          ? null
          : Feedback.wrapForTap(
              () async {
                await controller.forward();
                widget.onPressed?.call();
                await controller.reverse(from: controller.value);
              },
              context,
            ),
      onTapDown: widget.onPressed == null ? null : (_) => controller.forward(),
      onTapCancel: widget.onPressed == null
          ? null
          : () => controller.reverse(from: controller.value),
      onTapUp: widget.onPressed == null ? null : (_) => controller.reverse(),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Transform.rotate(
          angle: widget.rotate ? math.pi * 2 * animation.value : 0,
          child: Transform.scale(
            scale: widget.scale ? animation.value : 1,
            child: child,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
