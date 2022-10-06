import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text.rich(
          TextSpan(
            text: 'Conff',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 30,
            ),
            children: [
              TextSpan(
                text: 'eeg',
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            child: Text(
              'It\'s a pun on the word "config" and "coffee" :D',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          const Text(
            '''
Hi, hope you enjoyed MatchFee.

I know it's not perfect, but I tried my best and I had a lot of fun doing it.

Please, have a look at the README.md file to see how to use the app and how to test it.

There's also some info on what I'd have done if I had more time/knowledge.
''',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          const Carlos(),
          const Spacer(flex: 3),
          BlocBuilder<MatchesCubit, List<SavedCoffee>>(
            builder: (context, state) {
              if (state.isNotEmpty) {
                return Column(
                  children: [
                    const Align(
                      child: Text(
                        'Reset the data just in case you want to start over',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                              textStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text('Wipe data'),
                            onPressed: () {
                              context.showSnackbar(
                                'Are your sure you want to wipe the data?',
                                error: true,
                                onPressed: () =>
                                    context.read<MatchesCubit>().wipeData(),
                              );
                            }, //
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
          const Spacer(flex: 3),
        ],
      ).padded(),
    );
  }
}
