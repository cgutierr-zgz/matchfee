import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class OpenChats extends StatelessWidget {
  const OpenChats({
    super.key,
    required this.coffees,
  });

  final List<SavedCoffee> coffees;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: coffees.length,
        (context, index) {
          // Don't mind this, just a random condition
          // so that the UI looks a bit more interesting
          if (index.isEven && index % 3 == 0 && index % 5 == 0) {
            return const SizedBox.shrink();
          }

          return Row(
            children: [
              CoffeeAvatar(imagePath: coffees[index].imagePath),
              _ChatText(coffees: coffees, index: index),
            ].joinWith(const SizedBox(width: 10)),
          ).padded(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          );
        },
      ),
    );
  }
}

/// This widget is just a random widget that I made
/// to make the UI look a bit more interesting
/// don't mind the data <3
class _ChatText extends StatelessWidget {
  const _ChatText({
    required this.coffees,
    required this.index,
  });

  final List<SavedCoffee> coffees;
  final int index;

  String get _titleText => 'Coffe nº ${coffees.length - index + 1}';
  String get _chatText =>
      '''I love you to the moon and back ${coffees.length - index + 1} ${index + 1 <= 1 ? 'time' : 'times'}''';

  static const padding = SizedBox(width: 5);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (coffees[index].superLike)
                const Icon(Icons.star_rounded, color: Colors.blue),
              Expanded(
                child: Text(
                  _titleText,
                  style: theme.textTheme.headline5,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ].joinWith(padding),
          ),
          Row(
            children: [
              if (index.isEven || index % 3 == 0)
                const Icon(Icons.reply, color: Colors.grey),
              Expanded(
                child: Text(
                  _chatText,
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).padded(const EdgeInsets.only(right: 50)),
              ),
            ].joinWith(padding),
          )
        ],
      ),
    );
  }
}
