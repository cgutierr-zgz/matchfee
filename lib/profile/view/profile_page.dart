import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/profile/profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [ThemeToogler()],
        // TODO: Appbar conffeeg
      ),
      body: Center(
        child: Column(
          children: [
            _pun,
            const Text('Profile Page'),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(AppTheme.avatarUrl),
            ),
            const SocialLinks(),
            const WipeData(),
            // TODO: add info about me here

            const Spacer(),
            _text,
            const Carlos(),
            const Spacer(),
            TextButton(
              onPressed: () => showLicensePage(context: context),
              child: const Text('licenses'),
            )
          ],
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
