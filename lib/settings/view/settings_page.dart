import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pun,
          const Spacer(),
          _text,
          const Carlos(),
          const Spacer(flex: 3),
          const WipeData(),
          const Spacer(flex: 3),
        ],
      ).padded(),
    );
  }

  Widget get _pun => const Align(
        child: Text(
          'It\'s a pun on the word "config" and "coffee" :D',
          style: TextStyle(color: Colors.grey, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      );

  Widget get _text => const Text(
        '''Hi, hope you enjoyed MatchFee.\nI know it's not perfect, but I tried my best and I had a lot of fun doing it.\nPlease, have a look at the README.md file to see how to use the app and how to test it.\nThere's also some info on what I'd have done if I had more time/knowledge.''',
        style: TextStyle(fontSize: 17),
      );
}
