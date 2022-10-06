import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: BlocBuilder<MatchesCubit, List<SavedCoffee>>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const MatchesAppBar(),
              if (state.isEmpty) _error(l10n) else ..._body(state, l10n),
            ],
          );
        },
      ),
    );
  }

  Widget _error(AppLocalizations l10n) => SliverToBoxAdapter(
        child: Column(
          children: [
            const ErrorImage.square(size: 250).padded(),
            Text(
              l10n.noMatcheesYet,
              textAlign: TextAlign.center,
            ).padded(const EdgeInsets.symmetric(horizontal: 100))
          ],
        ),
      );

  List<Widget> _body(List<SavedCoffee> coffees, AppLocalizations l10n) => [
        InfoTitle(text: l10n.newMatchees.toUpperCase()),
        RecentMatchesRow(coffees: coffees),
        if (coffees.length > 1) ...[
          InfoTitle(text: l10n.openChats.toUpperCase()),
          OpenChats(coffees: coffees),
        ],
      ];
}
