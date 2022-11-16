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

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: coffees.isNotEmpty ? 1 : 0,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: coffees.isNotEmpty
                    ? () => context.showSnackbar(
                          'Are you sure you want to delete all matchees?',
                          error: true,
                          onPressed: coffeeRepository.deleteAllCoffees,
                          duration: const Duration(seconds: 5),
                        )
                    : null,
                child: const Text('Wipe data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
