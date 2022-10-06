import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/matches/matches.dart';

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
  void wipeData() => emit([]); // Would be nice to also delete files from disk

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
