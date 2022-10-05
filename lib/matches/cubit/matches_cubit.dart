import 'package:hydrated_bloc/hydrated_bloc.dart';

class MatchesCubit extends HydratedCubit<List<String>?> {
  MatchesCubit() : super([]);

  void addMatch(String match) {
    final matches = state ?? []
      ..add(match);

    emit(matches.reversed.toList());
  }

  @override
  List<String>? fromJson(Map<String, dynamic> json) =>
      json['matches'] as List<String>?;

  @override
  Map<String, dynamic>? toJson(List<String>? state) => {'matches': state};
}
