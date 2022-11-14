import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee/coffe.dart';
import 'package:matchfee/core/extensions.dart';
import 'package:matchfee/home/home.dart';
import 'package:matchfee/matches/matches.dart';
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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late bool isFirstTime;

  @override
  void initState() {
    super.initState();
    isFirstTime = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Center(
        child: BlocListener<MatchesCubit, List<Coffee>>(
          listener: (context, state) {
            if (state.isNotEmpty && !isFirstTime) {
              showDialog<void>(
                barrierColor: Colors.black.withOpacity(0.75),
                context: context,
                builder: (context) {
                  return const MatchDialog();
                },
              );
            }

            isFirstTime = false;
          },
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
                loaded: (images) => const SwippableCard(),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
