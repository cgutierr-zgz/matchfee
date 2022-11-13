import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/repo.dart';

part 'coffees_event.dart';
part 'coffees_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  CoffeeBloc({
    required CoffeeRepository coffeeRepository,
  })  : _coffeeRepository = coffeeRepository,
        super(const CoffeeLoading()) {
    _init();
    on<CoffeeStartEvent>(_onAppStarted);
    on<NextCoffeeEvent>(_onNextCoffees);
    on<PreviousCoffeeEvent>(_onPreviousCoffees);
    on<CoffeeErrorEvent>(_onError);
  }

  late final CoffeeRepository _coffeeRepository;

  List<String> photoStack = [];
  String? photoToDelete;

  Future<void> _init() async {
    // We initialize the app with some photos in the stack
    final photos = <String>[];
    for (var i = 0; i < 5; i++) {
      final photo = await _coffeeRepository.getRandomCoffee();
      photos.add(photo);
    }

    add(CoffeeStartEvent(photos));
  }

  void _onAppStarted(
    CoffeeStartEvent event,
    Emitter<CoffeeState> emit,
  ) {
    if (event.images.isEmpty) emit(CoffeesError(Exception('No images')));

    photoStack = event.images;
    emit(CoffeesLoaded(photoStack));
  }

  Future<void> _onNextCoffees(
    NextCoffeeEvent event,
    Emitter<CoffeeState> emit,
  ) async {
    if (photoStack.length > 1) {
      try {
        if (event.type == NextEventType.like ||
            event.type == NextEventType.superLike) {
          // We save the photo locally if its not a dislike
          await _coffeeRepository.saveCoffeeToDevice(
            event.image,
            superLike: event.type == NextEventType.superLike,
          );
        } else {
          // If its not a like we save it to the stack, so we can go back once
          photoToDelete = photoStack.first;
        }

        final photo = await _coffeeRepository.getRandomCoffee();
        photoStack
          ..removeAt(0) // We remove the front photo
          ..add(photo); // Then we add the new photo to the stack

        emit(const CoffeeLoading());
        emit(CoffeesLoaded(photoStack));
      } catch (e) {
        add(CoffeeErrorEvent(Exception('An error occured: $e')));
      }
    } else {
      add(CoffeeErrorEvent(Exception('Could not load more images')));
    }
  }

  Future<void> _onPreviousCoffees(
    PreviousCoffeeEvent event,
    Emitter<CoffeeState> emit,
  ) async {
    if (photoStack.length > 1) {
      // We add the previous photo to the frond and then we
      // delete the last photo so we dont have a super long stack of photos
      // in the background, looks bad
      photoStack
        ..insert(0, photoToDelete!)
        ..removeLast();
      photoToDelete = null;

      emit(const CoffeeLoading());
      emit(CoffeesLoaded(photoStack));
    } else {
      add(CoffeeErrorEvent(Exception('Could not load more images')));
    }
  }

  Future<void> _onError(
    CoffeeErrorEvent event,
    Emitter<CoffeeState> emit,
  ) async =>
      emit(CoffeesError(event.error));
}
