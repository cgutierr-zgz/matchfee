part of 'coffees_bloc.dart';

abstract class CoffeesState extends Equatable {
  const CoffeesState();

  @override
  List<Object> get props => [];
}

class CoffeesLoading extends CoffeesState {
  const CoffeesLoading();
}

class CoffeesLoaded extends CoffeesState {
  const CoffeesLoaded(this.images);

  final List<String> images;

  @override
  List<Object> get props => [images];
}

class CoffeesError extends CoffeesState {
  const CoffeesError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}
