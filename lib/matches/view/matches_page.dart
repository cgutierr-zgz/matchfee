import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MatchesCubit, List<String>>(
        builder: (context, images) {
          return CustomScrollView(
            slivers: [
              const MatchesAppBar(),
              if (images.isEmpty) _error else ..._body(images),
            ],
          );
        },
      ),
    );
  }

  static Widget get _error => SliverToBoxAdapter(
        child: Column(
          children: [
            const ErrorImage(size: 250).padded(),
            const Text(
              'Seems like you have no matchees yet... :(',
              textAlign: TextAlign.center,
            ).padded(const EdgeInsets.symmetric(horizontal: 100))
          ],
        ),
      );

  List<Widget> _body(List<String> images) => [
        const InfoTitle(text: 'NEW MATCHEES'),
        RecentMatchesRow(images: images),
        if (images.length > 1) ...[
          const InfoTitle(text: 'ALL MATCHEES'),
          OpenChats(images: images),
        ],
      ];
}
