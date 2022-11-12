// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Coffee extends Equatable {
  const Coffee({
    required this.path,
    required this.bytes,
    required this.isSuperLike,
  });
  final String path;
  final Uint8List bytes;
  final bool isSuperLike;

  Coffee copyWith({
    String? path,
    Uint8List? bytes,
    bool? isSuperLike,
  }) {
    return Coffee(
      path: path ?? this.path,
      bytes: bytes ?? this.bytes,
      isSuperLike: isSuperLike ?? this.isSuperLike,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'bytes': bytes.toList(),
      'isSuperLike': isSuperLike,
    };
  }

  factory Coffee.fromMap(Map<String, dynamic> map) {
    return Coffee(
      path: map['path'] as String,
      bytes: Uint8List.fromList(map['bytes'] as List<int>),
      isSuperLike: map['isSuperLike'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coffee.fromJson(String source) =>
      Coffee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [path, bytes, isSuperLike];
}
