import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';
import 'package:matchfee/matches/matches.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<HomeRepository>(
      create: (_) => HomeRepository(client: Client()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              homeRepository: context.read<HomeRepository>(),
              matchesCubit: context.read<MatchesCubit>(),
            ),
          ),
        ],
        child: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: Center(
        child: const CoffeeCards().padded(),
      ),
      bottomNavigationBar: SafeArea(
        child: const BottomRowHome().padded(const EdgeInsets.all(20)),
      ),
    );
  }
}
