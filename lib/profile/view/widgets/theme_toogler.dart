import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/profile/profile.dart';

class ThemeToogler extends StatelessWidget {
  const ThemeToogler({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: context.select(
        (SettingsCubit cubit) => cubit.state.themeMode == ThemeMode.dark
            ? const Icon(Icons.light_mode_rounded)
            : const Icon(Icons.dark_mode_rounded),
      ),
      onPressed: () => context.read<SettingsCubit>().toggleThemeMode(),
    );
  }
}
