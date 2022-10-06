import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class RecentMatchesRow extends StatelessWidget {
  const RecentMatchesRow({
    super.key,
    required this.coffees,
  });

  final List<SavedCoffee> coffees;

  static const _padding = EdgeInsets.symmetric(horizontal: 10);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 125,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: coffees.length,
          itemBuilder: (context, index) {
            final child = CoffeeAvatar(imagePath: coffees[index].imagePath);

            return index == 0 && coffees.length > 2
                ? _MultipleMatchesOverlay(
                    matches: coffees.length,
                    child: child,
                  ).padded(_padding)
                : child.padded(_padding);
          },
        ),
      ),
    );
  }
}

class _MultipleMatchesOverlay extends StatelessWidget {
  const _MultipleMatchesOverlay({
    required this.child,
    required this.matches,
  });

  final Widget child;
  final int matches;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.goldColor, width: 4),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              child,
              const Positioned(
                bottom: -12,
                child: Icon(
                  Icons.favorite,
                  color: AppTheme.goldColor,
                  shadows: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: -2,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Text(
            '$matches+ Likes',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
