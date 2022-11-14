import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee/coffe.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/profile/profile.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const _MatchfeeLogo(),
      leading: IconButton(
        icon: const Icon(Icons.person_rounded),
        onPressed: () => Navigator.of(context).push(
          // TODO: Extension 4 this and 4 scafold messenger
          MaterialPageRoute<dynamic>(
            builder: (context) => const ProfilePage(),
          ),
        ),
      ),
      actions: const [_MatchesButton()],
    );
  }
}

class _MatchfeeLogo extends StatelessWidget {
  const _MatchfeeLogo();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            text: 'Match',
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'fee',
                style: TextStyle(
                  color: theme.colorScheme.secondary,
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

class _MatchesButton extends StatelessWidget {
  const _MatchesButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesCubit, List<Coffee>>(
      builder: (context, state) {
        return Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.coffee_rounded),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<dynamic>(
                  builder: (context) => const MatchesPage(),
                ),
              ),
            ),
            _MatchesBadge(matches: state.length)
          ],
        );
      },
    );
  }
}

class _MatchesBadge extends StatelessWidget {
  const _MatchesBadge({
    required this.matches,
  });

  final int matches;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 5,
      child: IgnorePointer(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: matches != 0 ? 1 : 0,
          child: Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Text(
              '${matches > 9 ? '+9' : matches}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
