import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class OpenChats extends StatelessWidget {
  const OpenChats({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: images.length,
        (context, index) {
          // Don't mind this, just a random condition
          // so that the UI looks a bit more interesting
          if (index.isEven && index % 3 == 0 && index % 5 == 0) {
            return const SizedBox.shrink();
          }

          return Row(
            children: [
              CoffeeAvatar(imagePath: images[index]),
              _ChatText(images: images, index: index),
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
    required this.images,
    required this.index,
  });

  final List<String> images;
  final int index;

  String get _titleText => 'Coffe nº ${images.length - index + 1}';
  String get _chatText =>
      '''I love you to the moon and back ${images.length - index + 1} ${index + 1 <= 1 ? 'time' : 'times'}''';

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _titleText,
            style: theme.textTheme.headline5,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
            ].joinWith(const SizedBox(width: 5)),
          )
        ],
      ),
    );
  }
}
