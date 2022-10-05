import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: BlocBuilder<MatchesCubit, List<String>?>(
        builder: (context, state) {
          if (state == null) {
            // TODO(c): Show no matches yet :( or something like that
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                foregroundColor: Colors.black,
                backgroundColor: theme.scaffoldBackgroundColor,
                elevation: 0,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.forum_rounded,
                      color: Color(0xff6f4e37),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Match',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 30,
                        ),
                        children: const [
                          TextSpan(
                            text: 'ees',
                            style: TextStyle(
                              // TODO(c): find a good color for the (fee)
                              color: Color(0xff6f4e37), //brown.shade400,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].joinWith(const SizedBox(width: 10)),
                ),
              ),
              const InfoTitle(text: 'NEW MATCHES'),
              RecentMatchesRow(images: state),
              const InfoTitle(text: 'MESSAGES'),
              OpenChats(images: state),
            ],
          );
        },
      ),
    );
  }
}
