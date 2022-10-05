import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/home/home.dart';
import 'package:matchfee/matches/matches.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required HomeRepository homeRepository,
    required MatchesCubit matchesCubit,
  }) : super(const HomeLoading()) {
    _homeRepository = homeRepository;
    _matchesCubit = matchesCubit;
    _init();
    //on<HomeEvent>(_onAppStarted);
    on<HomeStartEvent>(_onAppStarted);
    on<LikeHomeEvent>(_onLikeHome);
    on<PreviousHomeEvent>(_onPreviousHome);
  }

  late final HomeRepository _homeRepository;
  late final MatchesCubit _matchesCubit;

  List<String> photoStack = [];

  // We initialize the app with two photos in the stack
  Future<void> _init() async {
    try {
      final photos = await _homeRepository.getCoffeeImages(2);

      add(HomeStartEvent(photos));
    } catch (e) {
      // emit error
    }
  }

  void _onAppStarted(
    HomeStartEvent event,
    Emitter<HomeState?> emit,
  ) {
    if (event.images == null) emit(HomeError(Exception('No images')));

    photoStack = event.images!;
    emit(HomeLoaded(photoStack));
  }

  Future<void> _onLikeHome(
    LikeHomeEvent event,
    Emitter<HomeState?> emit,
  ) async {
    if (photoStack.length > 1) {
      photoStack.removeAt(0);
      if (event.liked == true) {
        final path = await _homeRepository.saveImageToDevice(event.image);
        _matchesCubit.addMatch(path);
      }

      final photos = await _homeRepository.getCoffeeImages(1);
      photoStack.addAll(photos);

      emit(HomeLoaded(photoStack));
    } else {
      emit(HomeError(Exception('Could not load more images')));
    }
  }

  Future<void> _onPreviousHome(
    PreviousHomeEvent event,
    Emitter<HomeState?> emit,
  ) async {
    if (photoStack.length > 1) {
      final photos = await _homeRepository.getCoffeeImages(1);
      photoStack.addAll(photos);

      emit(HomeLoaded(photoStack));
    } else {
      emit(HomeError(Exception('Could not load more images')));
    }
  }
}
