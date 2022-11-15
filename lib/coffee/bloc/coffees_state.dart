part of 'coffees_bloc.dart';

abstract class CoffeesState extends Equatable {
  const CoffeesState();

  T when<T>({
    required T Function() loading,
    required T Function(Exception exception) error,
    required T Function(List<String> images) loaded,
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

  T? whenOrNull<T>({
    T Function()? loading,
    T Function(Exception exception)? error,
    T Function(List<String> images)? loaded,
  }) {
    if (this is CoffeeLoading) {
      return loading?.call();
    } else if (this is CoffeesError) {
      return error?.call((this as CoffeesError).error);
    } else if (this is CoffeesLoaded) {
      return loaded?.call((this as CoffeesLoaded).images);
    } else {
      throw Exception('Unknown state');
    }
  }

  T maybeWhen<T>({
    T Function()? loading,
    T Function(Exception exception)? error,
    T Function(List<String> images)? loaded,
    required T Function() orElse,
  }) {
    if (this is CoffeeLoading) {
      return loading?.call() ?? orElse();
    } else if (this is CoffeesError) {
      return error?.call((this as CoffeesError).error) ?? orElse();
    } else if (this is CoffeesLoaded) {
      return loaded?.call((this as CoffeesLoaded).images) ?? orElse();
    } else {
      throw Exception('Unknown state');
    }
  }

  dynamic map({
    required void Function(CoffeeLoading value) loading,
    required void Function(CoffeesError value) error,
    required void Function(CoffeesLoaded value) loaded,
  }) {
    if (this is CoffeeLoading) {
      return loading(this as CoffeeLoading);
    } else if (this is CoffeesError) {
      return error(this as CoffeesError);
    } else if (this is CoffeesLoaded) {
      return loaded(this as CoffeesLoaded);
    } else {
      throw Exception('Unknown state');
    }
  }

  dynamic mapOrNull({
    void Function(CoffeeLoading value)? loading,
    void Function(CoffeesError value)? error,
    void Function(CoffeesLoaded value)? loaded,
  }) {
    if (this is CoffeeLoading) {
      return loading?.call(this as CoffeeLoading);
    } else if (this is CoffeesError) {
      return error?.call(this as CoffeesError);
    } else if (this is CoffeesLoaded) {
      return loaded?.call(this as CoffeesLoaded);
    } else {
      throw Exception('Unknown state');
    }
  }

  dynamic maybeMap({
    void Function(CoffeeLoading value)? loading,
    void Function(CoffeesError value)? error,
    void Function(CoffeesLoaded value)? loaded,
  }) {
    if (this is CoffeeLoading) {
      return loading?.call(this as CoffeeLoading);
    } else if (this is CoffeesError) {
      return error?.call(this as CoffeesError);
    } else if (this is CoffeesLoaded) {
      return loaded?.call(this as CoffeesLoaded);
    } else {
      throw Exception('Unknown state');
    }
  }

  @override
  List<Object> get props => [
        when,
        maybeWhen,
        whenOrNull,
        map,
        maybeMap,
        mapOrNull,
      ];
}

class CoffeeLoading extends CoffeesState {
  const CoffeeLoading();
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
