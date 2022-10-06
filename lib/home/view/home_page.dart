import 'package:flutter/material.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Center(
        child: const CoffeeCards().padded(),
      ),
      bottomNavigationBar: SafeArea(
        child: const BottomRowHome().padded(const EdgeInsets.all(20)),
      ),
    );
  }
}
