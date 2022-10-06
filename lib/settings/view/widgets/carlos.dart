import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:matchfee/core/core.dart';

class Carlos extends StatefulWidget {
  const Carlos({super.key});

  @override
  State<Carlos> createState() => _CarlosState();
}

class _CarlosState extends State<Carlos> with TickerProviderStateMixin {
  late bool isHired;
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    isHired = false;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    animationController
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = TextStyle(color: theme.colorScheme.secondary, fontSize: 30);

    return GestureDetector(
      onTap: () => setState(() => isHired = true),
      child: Row(
        children: [
          Text('Carlos', style: style),
          Text(isHired ? '🦄' : '💙', style: style)
              // Just so you notice it and click it, hehe :)
              .animate(
                controller: animationController,
                onComplete: (_) => animationController.repeat(),
              )
              .scale(duration: const Duration(seconds: 1), begin: 1, end: 0.85)
        ],
      ),
    );
  }
}
