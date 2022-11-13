import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches.dart';
import 'package:matchfee/profile/profile.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const MatchfeeLogo(),
      leading: IconButton(
        icon: const Icon(
          Icons.person_rounded,
          color: AppTheme.primaryColor,
        ),
        onPressed: () => Navigator.of(context).push(
          // TODO: Extension 4 this and 4 scafold messenger
          MaterialPageRoute<dynamic>(
            builder: (context) => const ProfilePage(),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.coffee_rounded,
            color: AppTheme.primaryColor,
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<dynamic>(
              builder: (context) => const MatchesPage(),
            ),
          ),
        ),
      ],
    );
  }
}

class MatchfeeLogo extends StatelessWidget {
  const MatchfeeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            text: 'Match',
            style: const TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'fee',
                style: TextStyle(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Image.asset(
          'assets/images/logo.png',
          height: 40,
          width: 40,
        ),
      ],
    );
  }
}
