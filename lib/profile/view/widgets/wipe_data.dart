import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee/coffe.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/repo.dart';

class WipeData extends StatelessWidget {
  const WipeData({super.key});

  @override
  Widget build(BuildContext context) {
    final coffeeRepository = context.read<CoffeeRepository>();

    return BlocBuilder<MatchesCubit, List<Coffee>>(
      builder: (context, state) {
        if (state.isNotEmpty) {
          return TextButton(
            onPressed: coffeeRepository.deleteAllCoffees,
            // TODO: Add a confirmation dialog
            child: const Text('delete the data'),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
