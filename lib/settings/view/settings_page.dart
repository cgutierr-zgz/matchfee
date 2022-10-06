import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Widget get pun => const Align(
        child: Text(
          'It\'s a pun on the word "config" and "coffee" :D',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      );

  static Widget get text => const Text(
        '''
Hi, hope you enjoyed MatchFee.

I know it's not perfect, but I tried my best and I had a lot of fun doing it.

Please, have a look at the README.md file to see how to use the app and how to test it.

There's also some info on what I'd have done if I had more time/knowledge.
''',
        style: TextStyle(
          fontSize: 17,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pun,
          const Spacer(),
          text,
          const Carlos(),
          const Spacer(flex: 3),
          const WipeData(),
          const Spacer(flex: 3),
        ],
      ).padded(),
    );
  }
}
