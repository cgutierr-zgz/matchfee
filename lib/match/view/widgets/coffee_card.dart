import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';

class CoffeeCard extends StatelessWidget {
  const CoffeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 10,

      //ClipRRect(
      //  borderRadius: BorderRadius.circular(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://coffee.alexflipnote.dev/random',
            height: 500,
            width: double.maxFinite,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                height: 500,
                width: double.maxFinite,
                'assets/images/error.png',
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                height: 500,
                width: double.maxFinite,
                child: Center(
                  // TODO(c): Loading widget
                  child: Text('Loading...'),
                ),
              );
            },
          ),
          // TODO(c): Random info for the coffee
          Text(
            'Chloe, 27',
            style: theme.textTheme.headline5,
          ).padded(),
          Text(
            'English Teacher',
            style: theme.textTheme.bodyLarge,
          ).padded(),
          const SizedBox(height: 10),
        ].joinWith(const SizedBox(height: 10)),
      ),
    );
  }
}
