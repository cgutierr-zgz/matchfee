import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

class Carlos extends StatefulWidget {
  const Carlos({super.key});

  @override
  State<Carlos> createState() => _CarlosState();
}

class _CarlosState extends State<Carlos> with TickerProviderStateMixin {
  late bool isHired;

  @override
  void initState() {
    super.initState();
    isHired = false;
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
        ],
      ),
    );
  }
}
