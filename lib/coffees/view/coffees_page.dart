import 'package:flutter/material.dart';
import 'package:matchfee/coffees/coffees.dart';
import 'package:matchfee/core/core.dart';

class CoffeesPage extends StatelessWidget {
  const CoffeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoffeesAppBar(),
      body: Center(
        child: const CoffeeCards().padded(),
      ),
      bottomNavigationBar: SafeArea(
        child: const BottomNavigationRow().padded(const EdgeInsets.all(20)),
      ),
    );
  }
}
