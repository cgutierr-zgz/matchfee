import 'package:flutter/material.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          ],
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
            const Spacer(),
            Row(
              // TODO(c): make them cooler, and add this cool bubble effect to them too
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.yellow,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.star,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
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
