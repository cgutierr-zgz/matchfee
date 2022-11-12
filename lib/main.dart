import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:matchfee/coffee/coffee.dart';
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
