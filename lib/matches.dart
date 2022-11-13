import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee/domain/coffee.dart';
import 'package:matchfee/matches/cubit/matches_cubit.dart';
import 'package:matchfee/repo.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final coffeeRepository = context.read<CoffeeRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('matches'),
      ),
      body: Center(
        child: BlocBuilder<MatchesCubit, List<Coffee>>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                final data = state[index];

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
            );
          },
        ),
      ),
    );
  }
}
