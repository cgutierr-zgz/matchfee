part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
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
  List<Object?> get props => [images];
}

/// Event to trigger once we like a coffee
class NextHomeEvent extends HomeEvent {
  const NextHomeEvent({
    required this.image,
    required this.liked,
  });

  final String image;
  final bool liked;

  @override
  List<Object?> get props => [image, liked];
}

/// Event to trigger when we want to go to the previous coffee
class PreviousHomeEvent extends HomeEvent {
  const PreviousHomeEvent();

  @override
  List<Object?> get props => [];
}
