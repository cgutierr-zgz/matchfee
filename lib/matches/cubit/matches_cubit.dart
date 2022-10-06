// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

@immutable
class SavedCoffee extends Equatable {
  const SavedCoffee({
    required this.imagePath,
    required this.superLike,
  });

  final String imagePath;
  final bool superLike;

  SavedCoffee copyWith({
    String? imagePath,
    bool? superLike,
  }) {
    return SavedCoffee(
      imagePath: imagePath ?? this.imagePath,
      superLike: superLike ?? this.superLike,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'superLike': superLike,
    };
  }

  factory SavedCoffee.fromMap(Map<String, dynamic> map) {
    return SavedCoffee(
      imagePath: map['imagePath'] as String,
      superLike: map['superLike'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SavedCoffee.fromJson(String source) =>
      SavedCoffee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [imagePath, superLike];
}

class MatchesCubit extends HydratedCubit<List<SavedCoffee>> {
  MatchesCubit() : super([]);

  // Adds a new match to the list of matches and insert it at the start
  void addMatch(String match, {required bool isSuperLike}) {
    final matches = state
      ..insert(0, SavedCoffee(imagePath: match, superLike: isSuperLike));

    emit(matches.toList());
  }

  // Delete the given match from the list of matches
  void deleteMatch(String match) {
    final matches = state..removeWhere((element) => element.imagePath == match);

    emit(matches.toList());
  }

  // Delete the given match from the list of matches
  void wipeData() => emit([]);

  @override
  List<SavedCoffee> fromJson(Map<String, dynamic> json) {
    return (json['matches'] as List<dynamic>)
        .map((e) => SavedCoffee.fromJson(e as String))
        .toList();
  }

  @override
  Map<String, dynamic> toJson(List<SavedCoffee> state) {
    return <String, dynamic>{
      'matches': state.map((e) => e.toJson()).toList(),
    };
  }
}
