part of 'match_bloc.dart';

abstract class MatchState extends Equatable {
  const MatchState();
  
  @override
  List<Object> get props => [];
}

class MatchInitial extends MatchState {}
