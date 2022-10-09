import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/coffees/coffees.dart';
import 'package:matchfee/matches/matches.dart';

part 'coffees_event.dart';
part 'coffees_state.dart';

class CoffeesBloc extends Bloc<CoffeesEvent, CoffeesState> {
  CoffeesBloc({
    required CoffeesRepository coffeesRepository,
    required MatchesCubit matchesCubit,
  }) : super(const CoffeesLoading()) {
    _coffeesRepository = coffeesRepository;
    _matchesCubit = matchesCubit;

    _init();
    on<CoffeesStartEvent>(_onAppStarted);
    on<NextCoffeesEvent>(_onNextCoffees);
    on<PreviousCoffeesEvent>(_onPreviousCoffees);
    on<CoffeesErrorEvent>(_onError);
  }

  late final CoffeesRepository _coffeesRepository;
  late final MatchesCubit _matchesCubit;

  List<String> photoStack = [];
  String? photoToDelete;

  Future<void> _init() async {
    try {
      // We initialize the app with some photos in the stack
      final photos = await _coffeesRepository.getCoffeeImages(4);

      add(CoffeesStartEvent(photos));
    } catch (e) {
      add(CoffeesErrorEvent(Exception('Could not load more images: $e')));
    }
  }

  void _onAppStarted(
    CoffeesStartEvent event,
    Emitter<CoffeesState> emit,
  ) {
    if (event.images.isEmpty) emit(CoffeesError(Exception('No images')));

    photoStack = event.images;
    emit(CoffeesLoaded(photoStack));
  }

  Future<void> _onNextCoffees(
    NextCoffeesEvent event,
    Emitter<CoffeesState> emit,
  ) async {
    if (photoStack.length > 1) {
      try {
        if (event.type == NextEventType.like ||
            event.type == NextEventType.superLike) {
          // We save the photo locally if its not a dislike
          final path = await _coffeesRepository.saveImageToDevice(event.image);
          _matchesCubit.addMatch(
            path,
            isSuperLike: event.type == NextEventType.superLike,
          );
        } else {
          // If its not a like we save it to the stack, so we can go back once
          photoToDelete = photoStack.first;
        }

        final photos = await _coffeesRepository.getCoffeeImages(1);
        photoStack
          ..removeAt(0) // We remove the front photo
          ..addAll(photos); // Then we add the new photos to the stack

        emit(const CoffeesLoading());
        emit(CoffeesLoaded(photoStack));
      } catch (e) {
        add(CoffeesErrorEvent(Exception('An error occured: $e')));
      }
    } else {
      add(CoffeesErrorEvent(Exception('Could not load more images')));
    }
  }

  Future<void> _onPreviousCoffees(
    PreviousCoffeesEvent event,
    Emitter<CoffeesState> emit,
  ) async {
    if (photoStack.length > 1) {
      // We add the previous photo to the frond and then we
      // delete the last photo so we dont have a super long stack of photos
      // in the background, looks bad
      photoStack
        ..insert(0, photoToDelete!)
        ..removeLast();
      photoToDelete = null;

      emit(const CoffeesLoading());
      emit(CoffeesLoaded(photoStack));
    } else {
      add(CoffeesErrorEvent(Exception('Could not load more images')));
    }
  }

  Future<void> _onError(
    CoffeesErrorEvent event,
    Emitter<CoffeesState> emit,
  ) async =>
      emit(CoffeesError(event.error));
}
