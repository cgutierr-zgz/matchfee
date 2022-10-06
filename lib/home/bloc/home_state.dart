part of 'home_bloc.dart';

abstract class HomeState {
  const HomeState();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.images);

  final List<String> images;
}

class HomeError extends HomeState {
  const HomeError(this.error);

  final Exception error;
}
