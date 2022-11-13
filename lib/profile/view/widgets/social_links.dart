import 'package:flutter/material.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        // TODO: Fontwesome icons
        Text('github'),
        SizedBox(width: 10),
        Text('linkedin'),
        SizedBox(width: 10),
        Text('email'),
        SizedBox(width: 10),
        Text('website'),
      ],
    );
  }
}
