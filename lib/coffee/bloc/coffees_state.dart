part of 'coffee_bloc.dart';

abstract class CoffeeState extends Equatable {
  const CoffeeState();

  Widget when({
    required Widget Function() loading,
    required Widget Function(Exception exception) error,
    required Widget Function(List<String> images) loaded,
  }) {
    if (this is CoffeeLoading) {
      return loading();
    } else if (this is CoffeesError) {
      return error((this as CoffeesError).error);
    } else if (this is CoffeesLoaded) {
      return loaded((this as CoffeesLoaded).images);
    } else {
      throw Exception('Unknown state');
    }
  }

  @override
  List<Object> get props => [];
}

class CoffeeLoading extends CoffeeState {
  const CoffeeLoading();
}

class CoffeesLoaded extends CoffeeState {
  const CoffeesLoaded(this.images);

  final List<String> images;

  @override
  List<Object> get props => [images];
}

class CoffeesError extends CoffeeState {
  const CoffeesError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}
