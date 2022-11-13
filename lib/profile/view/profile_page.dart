import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/coffee/coffe.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/profile/cubit/settings_cubit.dart';
import 'package:matchfee/repo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final coffeeRepository = context.read<CoffeeRepository>();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('Profile Page'),
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/18635739?v=4',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('github'),
              SizedBox(width: 10),
              Text('linkedin'),
              SizedBox(width: 10),
              Text('email'),
              SizedBox(width: 10),
              Text('website'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              ThemeMode.values.length,
              (index) => IconButton(
                icon: const Icon(Icons.brightness_4),
                onPressed: () => context
                    .read<SettingsCubit>()
                    .toggleThemeMode(ThemeMode.values[index]),
              ),
            ),
          ),

          // TODO: Show this if theres any data in the device
          BlocBuilder<MatchesCubit, List<Coffee>>(
            builder: (context, state) {
              if (state.isNotEmpty) {
                return TextButton(
                  onPressed: coffeeRepository.deleteAllCoffees,
                  // TODO: Add a confirmation dialog
                  child: const Text('delete the data'),
                );
              }

              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
