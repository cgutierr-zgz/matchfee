import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class MatchDialog extends StatelessWidget {
  const MatchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _MatchTitle(),
            const _AvatarsMatch(),
            _MatchButton(
              icon: Icons.forum_rounded,
              onPressed: () => context
                ..pop()
                ..push(const MatchesPage()),
              text: 'Send a Message',
            ),
            _MatchButton(
              icon: Icons.style_rounded,
              onPressed: () => context.pop(),
              text: 'Keep Playing',
            ),
          ].joinWith(const SizedBox(height: 32)),
        ),
      ),
    );
  }
}

class _MatchTitle extends StatelessWidget {
  const _MatchTitle();

  static const style = TextStyle(
    color: Colors.white,
    fontFamily: 'HappyPink',
    fontSize: 50,
  );

  static const Set<String> randomMessages = {
    'You Matched!',
    'Say hi to your new match!',
    'Say hi!',
    "Now it's time to chat!",
    'Ready to start chatting?',
    'Pick up the conversation!',
    'Use the chat to get to know each other!',
    "It's time to start chatting!",
    "Let's start chatting!",
    "Let's get to know each other!",
    'Quick, say hi!',
    'What are you waiting for?',
    'Enjoy your new match!',
  };

  @override
  Widget build(BuildContext context) {
    final message = randomMessages.elementAt(
      Random().nextInt(randomMessages.length),
    );

    return Column(
      children: [
        const Text("It's a match!", style: style, textAlign: TextAlign.center),
        Text(
          message,
          style: style.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _AvatarsMatch extends StatelessWidget {
  const _AvatarsMatch();

  @override
  Widget build(BuildContext context) {
    final coffee = context.read<MatchesCubit>().state.first;
    final icon =
        coffee.isSuperLike ? Icons.star_rounded : Icons.favorite_rounded;
    final gradient = coffee.isSuperLike
        ? const LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.lightBlue,
            ],
          )
        : const LinearGradient(
            colors: [
              Colors.green,
              Colors.greenAccent,
            ],
          );

    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _avatar(MemoryImage(coffee.bytes)),
            _avatar(const NetworkImage(AppTheme.avatarUrl))
          ],
        ),
        Positioned(
          bottom: 15,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 50),
              GradientIcon(icon: icon, size: 47, gradient: gradient),
            ],
          ),
        ),
      ],
    );
  }

  Widget _avatar(ImageProvider<Object> image) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 50,
      child: CircleAvatar(
        backgroundImage: image,
        radius: 47,
      ),
    );
  }
}

class _MatchButton extends StatelessWidget {
  const _MatchButton({
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  final String text;
  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              backgroundColor: Colors.grey.withOpacity(0.25),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 32,
              ),
            ),
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(text),
          ),
        ),
      ],
    );
  }
}
