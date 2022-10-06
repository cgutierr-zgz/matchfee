import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class SavedCoffee extends Equatable {
  const SavedCoffee({
    required this.imagePath,
    required this.superLike,
  });
  factory SavedCoffee.fromJson(String source) =>
      SavedCoffee.fromMap(json.decode(source) as Map<String, dynamic>);

  factory SavedCoffee.fromMap(Map<String, dynamic> map) {
    return SavedCoffee(
      imagePath: map['imagePath'] as String,
      superLike: map['superLike'] as bool,
    );
  }

  final String imagePath;
  final bool superLike;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'superLike': superLike,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [imagePath, superLike];
}
