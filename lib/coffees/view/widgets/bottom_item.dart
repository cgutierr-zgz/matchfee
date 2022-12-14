import 'dart:async';

import 'package:flutter/material.dart';

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

class _BottomItemState extends State<BottomItem> {
  late ValueNotifier<bool> isEnabled;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEnabled = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Small debounce to prevent multiple taps
  void onPressed() {
    isEnabled.value = false;
    widget.onPressed!.call();
    timer = Timer(
      const Duration(milliseconds: 250),
      () => isEnabled.value = true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: widget.size,
      width: widget.size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.onPressed == null ? Colors.grey.shade300 : Colors.white,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ValueListenableBuilder(
        valueListenable: isEnabled,
        builder: (context, value, child) {
          return MaterialButton(
            height: widget.size,
            onPressed: widget.onPressed == null || !value ? null : onPressed,
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
            child: Icon(
              widget.icon,
              size: widget.size - 20,
              color: widget.onPressed == null
                  ? Colors.grey.shade100
                  : widget.color,
            ),
          );
        },
      ),
    );
  }
}
