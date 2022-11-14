import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee/coffe.dart';
import 'package:matchfee/core/extensions.dart';
import 'package:matchfee/home/home.dart';
import 'package:matchfee/repo.dart';

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
    final size = context.currentSize;

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Center(
        child: BlocBuilder<CoffeeBloc, CoffeeState>(
          builder: (context, state) {
            return state.when(
              loading: () => const CircularProgressIndicator(),
              loaded: (images) => Builder(
                builder: (context) {
                  return Stack(
                    children: List.generate(
                      images.length,
                      (index) {
                        final height = size.height * 0.70;
                        final width = size.width * 0.90;

                        // TODO: Blur the one in the back a lot
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            images.reversed.toList()[index],
                            height: height,
                            width: width,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Image.asset(
                                'assets/images/loading.png',
                                height: height,
                                width: width,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/error.png',
                                height: height,
                                width: width,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              );
                            },
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
                  icon: const Icon(Icons.replay_rounded),
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
