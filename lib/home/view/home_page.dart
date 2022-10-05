import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMatchPage(),
      body: Center(
        child: const CoffeeCard().padded(),
      ),
      bottomNavigationBar: SafeArea(
        child: const BottomHomeRow().padded(),
      ),
    );
  }
}
