import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/profile/profile.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leadTitle: 'Match',
      trailTitle: 'fee',
      showAppIcon: true,
      leading: IconButton(
        icon: const Icon(Icons.person_rounded),
        onPressed: () => context.push(const ProfilePage()),
      ),
      actions: const [_MatchesButton()],
    );
  }
}

class _MatchesButton extends StatelessWidget {
  const _MatchesButton();

  @override
  Widget build(BuildContext context) {
    final coffees = context.watch<MatchesCubit>().state;
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.coffee_rounded),
          onPressed: () => context.push(const MatchesPage()),
        ),
        _MatchesBadge(matches: coffees.length)
      ],
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
