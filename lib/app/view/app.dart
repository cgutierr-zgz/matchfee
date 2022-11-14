import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';
import 'package:matchfee/profile/profile.dart';

class Matchfee extends StatelessWidget {
  const Matchfee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.select((SettingsCubit c) => c.state.themeMode),
      home: const HomePage(),
    );
  }
}
