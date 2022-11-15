part of 'coffees_bloc.dart';

abstract class CoffeesEvent extends Equatable {
  const CoffeesEvent();
  @override
  List<Object> get props => [];
}

/// Event to trigger once we like a coffee
class CoffeeErrorEvent extends CoffeesEvent {
  const CoffeeErrorEvent(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}

/// Event to trigger once we like a coffee
class CoffeeStartEvent extends CoffeesEvent {
  const CoffeeStartEvent(this.images);

  final List<String> images;

  @override
  List<Object> get props => [images];
}

enum NextEventType { like, dislike, superLike }

/// Event to trigger once we like a coffee
class NextCoffeeEvent extends CoffeesEvent {
  const NextCoffeeEvent.like({
    required this.image,
  }) : type = NextEventType.like;

  const NextCoffeeEvent.superLike({
    required this.image,
  }) : type = NextEventType.superLike;

  const NextCoffeeEvent.dislike({
    required this.image,
  }) : type = NextEventType.dislike;

  final String image;
  final NextEventType type;

  @override
  List<Object> get props => [image, type];
}

/// Event to trigger when we want to go to the previous coffee
/// This event is only valid if we dislaked one coffee, like in Tin...Matchfee
class PreviousCoffeeEvent extends CoffeesEvent {
  const PreviousCoffeeEvent();
}
