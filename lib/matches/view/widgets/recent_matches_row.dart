import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class RecentMatchesRow extends StatelessWidget {
  const RecentMatchesRow({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return CoffeeAvatar(imagePath: images[index]).padded(
              const EdgeInsets.symmetric(horizontal: 10),
            );
          },
        ),
      ),
    );
  }
}
