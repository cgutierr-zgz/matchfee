part of 'match_bloc.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

/// Event to trigger once we like a coffee
class LikeMatchEvent extends Equatable {
  const LikeMatchEvent(this.image);

  final String image;

  @override
  List<Object> get props => [];
}

/// Event to trigger once we like a coffee
class SuperLikeMatchEvent extends Equatable {
  const SuperLikeMatchEvent(this.image);

  final String image;

  @override
  List<Object> get props => [];
}

/// Event to trigger once we don't like a coffee
class DislikeMatchEvent extends Equatable {
  const DislikeMatchEvent();

  @override
  List<Object> get props => [];
}

/// Event to trigger when we want to go to the previous coffee
class PreviousMatchRequestedEvent extends Equatable {
  const PreviousMatchRequestedEvent();

  @override
  List<Object> get props => [];
}
