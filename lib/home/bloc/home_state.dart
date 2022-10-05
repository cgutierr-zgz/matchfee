part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.images);

  final List<String> images;

  @override
  List<Object> get props => [images];
}

class HomeError extends HomeState {
  const HomeError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}
