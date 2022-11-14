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
        child: BlocConsumer<CoffeeBloc, CoffeeState>(
          listener: (context, state) {
            if (state is CoffeesError) {
              context.showSnackbar(state.error.toString(), error: true);
            }
          },
          builder: (context, state) {
            return state.when(
              loading: () => const CircularProgressIndicator(),
              error: (error) => Text(error.toString()),
              loaded: (images) => SwippableCards(images: images),
            );
          },
        ),
      ),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
