part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

/// Event to trigger once we like a coffee
class HomeErrorEvent extends HomeEvent {
  const HomeErrorEvent(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}

/// Event to trigger once we like a coffee
class HomeStartEvent extends HomeEvent {
  const HomeStartEvent(this.images);

  final List<String> images;

  @override
  List<Object> get props => [images];
}

enum NextEventType { like, dislike, superLike }

/// Event to trigger once we like a coffee
class NextHomeEvent extends HomeEvent {
  const NextHomeEvent.like({
    required this.image,
  }) : type = NextEventType.like;

  const NextHomeEvent.superLike({
    required this.image,
  }) : type = NextEventType.superLike;

  const NextHomeEvent.dislike({
    required this.image,
  }) : type = NextEventType.dislike;

  final String image;
  final NextEventType type;

  @override
  List<Object> get props => [image, type];
}

/// Event to trigger when we want to go to the previous coffee
/// This event is only valid if we dislaked one coffee, like in Tin...Matchfee
class PreviousHomeEvent extends HomeEvent {
  const PreviousHomeEvent();
}
