import 'dart:async';

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
  late Timer timer;
  late final ValueNotifier<bool> isEnabled;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    isEnabled = ValueNotifier<bool>(true);
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
        // TODO(c): add this on tapdown to make it more responsive
        onPressed: isEnabled.value
            ? () {
                isEnabled.value = false;
                playAnimation();
                widget.onPressed?.call();
                timer = Timer(
                  const Duration(milliseconds: 250),
                  () => isEnabled.value = true,
                );
              }
            : null,
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
