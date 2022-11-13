// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Settings extends Equatable {
  const Settings({
    required this.themeMode,
  });

  final ThemeMode themeMode;
  // ... other settings

  Settings copyWith({ThemeMode? themeMode}) =>
      Settings(themeMode: themeMode ?? this.themeMode);

  Map<String, dynamic> toJson() => {'themeMode': themeMode.index};

  factory Settings.fromJson(Map<String, dynamic> map) =>
      Settings(themeMode: ThemeMode.values[map['themeMode'] as int]);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [themeMode];
}
