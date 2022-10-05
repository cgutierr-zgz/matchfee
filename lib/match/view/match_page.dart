import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/match/match.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          // TODO(carlos): add appbar icon theme + theme in general
          icon: const Icon(
            Icons.settings,
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 30, width: 30),
            const Text.rich(
              TextSpan(
                text: 'Match',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: 'Fee',
                    style: TextStyle(
                      // TODO(c): find a good color for the (fee)
                      color: Colors.red, //brown.shade400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ].joinWith(const SizedBox(width: 10)),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.chat_bubble,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Card(
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
            ).padded(),
            const Spacer(flex: 2),
            const BottomMatchRow(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class MatchView extends StatelessWidget {
  const MatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
