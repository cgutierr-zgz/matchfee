import 'package:flutter/material.dart';
import 'package:matchfee/profile/profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [ThemeToogler()],
      ),
      body: Center(
        child: Column(
          children: const [
            Text('Profile Page'),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/18635739?v=4',
              ),
            ),
            SocialLinks(),
            WipeData(),
            // TODO: add info about me here
          ],
        ),
      ),
    );
  }
}
