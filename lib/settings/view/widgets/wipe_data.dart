import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class WipeData extends StatelessWidget {
  const WipeData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesCubit, List<SavedCoffee>>(
      builder: (context, state) {
        if (state.isNotEmpty) {
          return Column(
            children: [
              _hintResetData,
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
                      onPressed: () => onPressed(context),
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget get _hintResetData => const Align(
        child: Text(
          'Reset the data just in case you want to start over',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      );

  void onPressed(BuildContext context) => context.showSnackbar(
        'Are your sure you want to wipe the data?',
        error: true,
        onPressed: () => context.read<MatchesCubit>().wipeData(),
      );
}
