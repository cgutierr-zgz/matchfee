import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/match/match.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMatchPage(),
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 2),
            const CoffeeCard().padded(),
            const Spacer(flex: 2),
            const BottomMatchRow().padded(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class MatchView extends StatelessWidget {
  const MatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
