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
    final theme = context.theme;

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coffe nº ${images.length - index + 1}',
                      style: theme.textTheme.headline5,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        // Don't mind this, just a random condition
                        // so that the UI looks a bit more interesting
                        if (index.isEven || index % 3 == 0)
                          const Icon(Icons.reply, color: Colors.grey),
                        Expanded(
                          child: Text(
                            '''I love your to the moon and back ${images.length - index + 1} ${index + 1 <= 1 ? 'time' : 'times'}''',
                            style: theme.textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).padded(const EdgeInsets.only(right: 50)),
                        ),
                      ].joinWith(const SizedBox(width: 5)),
                    )
                  ],
                ),
              ),
            ].joinWith(const SizedBox(width: 10)),
          ).padded(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          );
        },
      ),
    );
  }
}
