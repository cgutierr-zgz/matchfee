import 'package:hydrated_bloc/hydrated_bloc.dart';

class MatchesCubit extends HydratedCubit<List<String>> {
  MatchesCubit() : super([]);

  // Adds a new match to the list of matches and insert it at the start
  void addMatch(String match) {
    final matches = state..insert(0, match);

    emit(matches.toList());
  }

  // Delete the given match from the list of matches
  void deleteMatch(String match) {
    final matches = state..remove(match);

    emit(matches.toList());
  }

  @override
  List<String> fromJson(Map<String, dynamic> json) =>
      json['matches'] as List<String>;

  @override
  Map<String, dynamic>? toJson(List<String> state) => {'matches': state};
}
