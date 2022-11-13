import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/profile/profile.dart';

class ThemeToogler extends StatelessWidget {
  const ThemeToogler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, Settings>(
      builder: (context, state) {
        return IconButton(
          icon: state.themeMode == ThemeMode.dark
              ? const Icon(Icons.light_mode)
              : const Icon(Icons.dark_mode),
          onPressed: () => context.read<SettingsCubit>().toggleThemeMode(),
        );
      },
    );
  }
}
