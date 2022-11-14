import 'package:flutter/material.dart';

class CustomAnimatedButton extends StatefulWidget {
  const CustomAnimatedButton({
    super.key,
    this.onPressed,
    required this.child,
  });

  final void Function()? onPressed;
  final Widget child;

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
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO: Add debounce
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
        builder: (context, child) => Transform(
          transform: Matrix4.identity()..scale(animation.value),
          //..rotate(
          //  Axis.horizontal,
          //  animation.value * 0.1,
          //),
          //scale: animation.value,
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}
