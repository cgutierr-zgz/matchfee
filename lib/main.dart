import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:matchfee/coffee/bloc/coffee_bloc.dart';
import 'package:matchfee/matches.dart';
import 'package:matchfee/repo.dart';

void main() {
  final client = Client();

  runApp(
    RepositoryProvider(
      create: (_) => CoffeeRepository(client: client),
      child: const Matchfee(),
    ),
  );
}

class Matchfee extends StatelessWidget {
  const Matchfee({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final coffeeRepository = context.read<CoffeeRepository>();

    return BlocProvider(
      create: (context) => CoffeeBloc(coffeeRepository: coffeeRepository),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<CoffeeRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matchfee'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<MatchesPage>(
                builder: (context) => const MatchesPage(),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CoffeeBloc, CoffeeState>(
              builder: (context, state) {
                return state.when(
                  loading: () => const CircularProgressIndicator(),
                  loaded: (images) => Builder(
                    builder: (context) {
                      return Stack(
                        children: List.generate(
                          images.length,
                          (index) {
                            return Transform.rotate(
                              angle: index * 0.1,
                              child: Image.network(
                                images.reversed.toList()[index],
                                height: 450,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  error: (error) => Text(error.toString()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<CoffeeBloc, CoffeeState>(
        builder: (context, state) {
          final isLoaded = state is CoffeesLoaded;

          return Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.undo_rounded),
                  onPressed: isLoaded &&
                          context.read<CoffeeBloc>().photoToDelete != null
                      ? () => context.read<CoffeeBloc>().add(
                            const PreviousCoffeeEvent(),
                          )
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: isLoaded
                      ? () => context.read<CoffeeBloc>().add(
                            NextCoffeeEvent.dislike(image: state.images.first),
                          )
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_rounded),
                  onPressed: isLoaded
                      ? () => context
                          .read<CoffeeBloc>()
                          .add(NextCoffeeEvent.like(image: state.images.first))
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.star_rounded),
                  onPressed: isLoaded
                      ? () => context.read<CoffeeBloc>().add(
                            NextCoffeeEvent.superLike(
                              image: state.images.first,
                            ),
                          )
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
