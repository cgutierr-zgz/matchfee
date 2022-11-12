import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee.dart';
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
        child: FutureBuilder<List<Coffee>>(
          future: coffeeRepository.getDeviceCoffees(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.requireData[index];

                  return Stack(
                    children: [
                      Image.memory(data.bytes),
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
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
