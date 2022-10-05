import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/match/match.dart';

class BottomMatchRow extends StatelessWidget {
  const BottomMatchRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // TODO(c): make them cooler, and add this cool bubble effect to them too
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        BottomItem.small(
          icon: Icons.undo_rounded,
          color: Colors.yellow,
          onPressed: () {},
        ),
        BottomItem(
          icon: Icons.close_rounded,
          color: Colors.red,
          onPressed: () {},
        ),
        BottomItem(
          icon: Icons.favorite_rounded,
          color: Colors.green,
          onPressed: () {},
        ),
        BottomItem.small(
          icon: Icons.star_rounded,
          color: Colors.blue,
          onPressed: () {},
        ),
        const Spacer(),
      ].joinWith(const SizedBox(width: 20)),
    );
  }
}
