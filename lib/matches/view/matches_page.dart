import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/cubit/matches_cubit.dart';
import 'package:matchfee/repo.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final coffeeRepository = context.read<CoffeeRepository>();
    final coffees = context.watch<MatchesCubit>().state;

    return Scaffold(
      appBar: const CustomAppBar(leadTitle: 'Match', trailTitle: 'ees'),
      body: Center(
        child: coffees.isEmpty
            ? const Text('No matches')
            : ListView.builder(
                itemCount: coffees.length,
                itemBuilder: (context, index) {
                  final data = coffees[index];

                  return Stack(
                    children: [
                      Image.memory(data.bytes),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: IconButton(
                          onPressed: () {
                            coffeeRepository.deleteCoffee(data);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      if (data.isSuperLike)
                        const Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
