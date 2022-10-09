import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/coffees/coffees.dart';

import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Coffees Bloc', () {
    late CoffeesBloc coffeesBloc;
    late MatchesCubit matchesCubit;
    final exception = Exception('error');
    final images = ['test', 'test'];
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit();
      coffeesBloc = CoffeesBloc(
        matchesCubit: matchesCubit,
        coffeesRepository: CoffeesRepository(client: mockClient),
        // Mind that we have the images named 'test' in the mock client
        // and on top so images will appear with the same name
      );
    });

    test('Initial state is Loading', () {
      expect(coffeesBloc.state, equals(const CoffeesLoading()));
    });

    blocTest<CoffeesBloc, CoffeesState>(
      'Emits new matches when Start event is added',
      build: () => coffeesBloc,
      act: (bloc) => bloc.add(CoffeesStartEvent(images)),
      expect: () => [
        equals(CoffeesLoaded(images)),
        equals(const CoffeesLoaded(['test', 'test', 'test', 'test'])),
      ],
    );

    /* 
    * Having trouble testing the saveImage to device...
    * So i can't relly test:
    * NextCoffeesEvent.like and NextCoffeesEvent.superLike :/
    * Since both of them call saveImage

    blocTest<CoffeesBloc, CoffeesState>(
      'Adds a new matchee',
      build: () => CoffeesBloc,
      act: (bloc) => bloc
        ..add(CoffeesStartEvent(images))
        ..add(
          NextCoffeesEvent.like(
            image: images[0],
          ),
        ),
      expect: () => [
        CoffeesLoaded(images),
        const CoffeesLoaded(['test', 'test', 'test', 'test']),
      ],
    );
    */

    blocTest<CoffeesBloc, CoffeesState>(
      'Dislikes the given matchee',
      build: () => coffeesBloc,
      act: (bloc) => bloc
        ..add(CoffeesStartEvent(images))
        ..add(
          NextCoffeesEvent.dislike(image: images[0]),
        ),
      expect: () => [
        equals(const CoffeesLoaded(['test', 'test'])),
        equals(const CoffeesLoading()),
        equals(const CoffeesLoaded(['test', 'test'])),
        equals(const CoffeesLoaded(['test', 'test', 'test', 'test'])),
      ],
    );
    blocTest<CoffeesBloc, CoffeesState>(
      'Dislikes the given matchee and goes back to the previous one',
      build: () => coffeesBloc,
      act: (bloc) => bloc
        ..add(CoffeesStartEvent(images))
        ..add(
          NextCoffeesEvent.dislike(image: images[0]),
        )
        ..add(
          const PreviousCoffeesEvent(),
        ),
      expect: () => [
        equals(const CoffeesLoaded(['test', 'test'])),
        equals(const CoffeesLoading()),
        equals(const CoffeesLoaded(['test', 'test'])),
        equals(const CoffeesLoading()),
        equals(const CoffeesLoaded(['test', 'test'])),
        equals(const CoffeesLoaded(['test', 'test', 'test', 'test'])),
      ],
    );

    blocTest<CoffeesBloc, CoffeesState>(
      'Emits an error after starting',
      build: () => coffeesBloc,
      act: (bloc) => bloc
        ..add(CoffeesStartEvent(images))
        ..add(CoffeesErrorEvent(exception)),
      expect: () => [
        equals(CoffeesLoaded(images)),
        equals(CoffeesError(exception)),
        equals(const CoffeesLoaded(['test', 'test', 'test', 'test'])),
      ],
    );

    test('Testing the props of the states', () {
      final coffeesLoaded = CoffeesLoaded(images);
      final coffeesError = CoffeesError(exception);
      const coffeesLoading = CoffeesLoading();

      expect(coffeesLoaded.props, [images]);
      expect(coffeesError.props, [exception]);
      expect(coffeesLoading.props, <Object>[]);
    });

    test('Testing the props of the events', () {
      final coffeesStartEvent = CoffeesStartEvent(images);
      final coffeesErrorEvent = CoffeesErrorEvent(exception);
      final nextCoffeesEventLike = NextCoffeesEvent.like(image: images[0]);
      final nextCoffeesEventSuperLike =
          NextCoffeesEvent.superLike(image: images[0]);
      final nextCoffeesEventDislike =
          NextCoffeesEvent.dislike(image: images[0]);
      const previousCoffeesEvent = PreviousCoffeesEvent();

      expect(coffeesStartEvent.props, [images]);
      expect(coffeesErrorEvent.props, [exception]);
      expect(
        nextCoffeesEventLike.props,
        [images[0], NextEventType.like],
      );
      expect(
        nextCoffeesEventSuperLike.props,
        [images[0], NextEventType.superLike],
      );
      expect(
        nextCoffeesEventDislike.props,
        [images[0], NextEventType.dislike],
      );
      expect(previousCoffeesEvent.props, <Object>[]);
    });
  });
}
