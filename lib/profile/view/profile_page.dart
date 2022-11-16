import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/profile/profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadTitle: 'Conf',
        trailTitle: 'eeg',
        actions: [ThemeToogler()],
      ),
      body: Center(
        child: Column(
          children: [
            _pun,
            Image.asset('assets/images/loading.png', height: 100, width: 100),
            _text,
            const Carlos(),
            const Spacer(flex: 2),
            const WipeData(),
          ].joinWith(const SizedBox(height: 20)),
        ).padded(),
      ),
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
        '''Hi, hope you enjoyed MatchFee.\nI tried my best and I had a lot of fun doing it.\nPlease, have a look at the README.md file to see how to use the app and how to test it.''',
        style: TextStyle(fontSize: 17),
      );
}
