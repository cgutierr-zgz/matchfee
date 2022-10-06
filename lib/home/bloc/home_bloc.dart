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
    on<HomeStartEvent>(_onAppStarted);
    on<NextHomeEvent>(_onLikeHome);
    on<PreviousHomeEvent>(_onPreviousHome);
    on<HomeErrorEvent>(_onError);
  }

  late final HomeRepository _homeRepository;
  late final MatchesCubit _matchesCubit;

  List<String> photoStack = [];
  String? photoToDelete;

  Future<void> _init() async {
    try {
      // We initialize the app with some photos in the stack
      final photos = await _homeRepository.getCoffeeImages(4);

      add(HomeStartEvent(photos));
    } catch (e) {
      add(HomeErrorEvent(Exception('Could not load more images')));
    }
  }

  void _onAppStarted(
    HomeStartEvent event,
    Emitter<HomeState> emit,
  ) {
    if (event.images.isEmpty) emit(HomeError(Exception('No images')));

    photoStack = event.images;
    emit(HomeLoaded(photoStack));
  }

  Future<void> _onLikeHome(
    NextHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (photoStack.length > 1) {
      if (event.type == NextEventType.like ||
          event.type == NextEventType.superLike) {
        // We save the photo locally if its not a dislike
        final path = await _homeRepository.saveImageToDevice(event.image);
        _matchesCubit.addMatch(
          path,
          isSuperLike: event.type == NextEventType.superLike,
        );
      } else {
        // If its not a like we save it to the stack, so we can go back once
        photoToDelete = photoStack[0];
      }

      final photos = await _homeRepository.getCoffeeImages(1);
      photoStack
        ..addAll(photos)
        ..removeAt(0);

      emit(const HomeLoading());
      emit(HomeLoaded(photoStack));
    } else {
      add(HomeErrorEvent(Exception('Could not load more images')));
    }
  }

  Future<void> _onPreviousHome(
    PreviousHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (photoStack.length > 1) {
      // We add the previous photo to the frond and then we
      // delete the last photo so we dont have a super long stack of photos
      // in the background, looks bad
      photoStack
        ..insert(0, photoToDelete!)
        ..removeLast();
      photoToDelete = null;

      emit(const HomeLoading());
      emit(HomeLoaded(photoStack));
    } else {
      add(HomeErrorEvent(Exception('Could not load more images')));
    }
  }

  Future<void> _onError(
    HomeErrorEvent event,
    Emitter<HomeState> emit,
  ) async =>
      emit(HomeError(event.error));
}
