import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'match_state.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit() : super(MatchInitial());
}
