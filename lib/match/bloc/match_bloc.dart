import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/match/domain/match_repository.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends HydratedBloc<MatchEvent, MatchState> {
  MatchBloc({required MatchRepository matchRepository})
      : super(MatchInitial()) {
    _matchRepository = matchRepository;
    on<MatchEvent>(_onAppStarted);
  }

  late final MatchRepository _matchRepository;

  void _onAppStarted(MatchEvent event_, Emitter<MatchState> emit) {}

  @override
  MatchState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(MatchState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
