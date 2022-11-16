import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/repo.dart';

class WipeData extends StatelessWidget {
  const WipeData({super.key});

  @override
  Widget build(BuildContext context) {
    final coffeeRepository = context.read<CoffeeRepository>();
    final coffees = context.watch<MatchesCubit>().state;

    if (coffees.isNotEmpty) {
      return TextButton(
        onPressed: () => context.showSnackbar(
          'Are you sure you want to delete all matchees?',
          error: true,
          onPressed: coffeeRepository.deleteAllCoffees,
          duration: const Duration(seconds: 5),
        ),
        child: const Text('Wipe data'),
      );
    }

    return const SizedBox.shrink();
  }
}
