import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/home/home.dart';

import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Home Bloc', () {
    late HomeBloc homeBloc;
    late MatchesCubit matchesCubit;
    final exception = Exception('error');
    final images = ['test', 'test'];

    setUp(() {
      matchesCubit = buildMatchesCubit();
      homeBloc = HomeBloc(
        matchesCubit: matchesCubit,
        homeRepository: HomeRepository(client: mockClient),
        // Mind that we have the images named 'test' in the mock client
        // and on top so images will appear with the same name
      );
    });

    test('Initial state is Loading', () {
      expect(homeBloc.state, equals(const HomeLoading()));
    });

    blocTest<HomeBloc, HomeState>(
      'Emits new matches when Start event is added',
      build: () => homeBloc,
      act: (bloc) => bloc.add(HomeStartEvent(images)),
      expect: () => [
        equals(HomeLoaded(images)),
        equals(const HomeLoaded(['test', 'test', 'test', 'test'])),
      ],
    );

    /* 
    * Having trouble testing the saveImage to device...
    * So i can't relly test:
    * NextHomeEvent.like and NextHomeEvent.superLike :/
    * Since both of them call saveImage

    blocTest<HomeBloc, HomeState>(
      'Adds a new matchee',
      build: () => homeBloc,
      act: (bloc) => bloc
        ..add(HomeStartEvent(images))
        ..add(
          NextHomeEvent.like(
            image: images[0],
          ),
        ),
      expect: () => [
        HomeLoaded(images),
        const HomeLoaded(['test', 'test', 'test', 'test']),
      ],
    );
    */

    blocTest<HomeBloc, HomeState>(
      'Dislikes the given matchee',
      build: () => homeBloc,
      act: (bloc) => bloc
        ..add(HomeStartEvent(images))
        ..add(
          NextHomeEvent.dislike(image: images[0]),
        ),
      expect: () => [
        equals(const HomeLoaded(['test', 'test'])),
        equals(const HomeLoading()),
        equals(const HomeLoaded(['test', 'test'])),
        equals(const HomeLoaded(['test', 'test', 'test', 'test'])),
      ],
    );
    blocTest<HomeBloc, HomeState>(
      'Dislikes the given matchee and goes back to the previous one',
      build: () => homeBloc,
      act: (bloc) => bloc
        ..add(HomeStartEvent(images))
        ..add(
          NextHomeEvent.dislike(image: images[0]),
        )
        ..add(
          const PreviousHomeEvent(),
        ),
      expect: () => [
        equals(const HomeLoaded(['test', 'test'])),
        equals(const HomeLoading()),
        equals(const HomeLoaded(['test', 'test'])),
        equals(const HomeLoading()),
        equals(const HomeLoaded(['test', 'test'])),
        equals(const HomeLoaded(['test', 'test', 'test', 'test'])),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'Emits an error after starting',
      build: () => homeBloc,
      act: (bloc) => bloc
        ..add(HomeStartEvent(images))
        ..add(HomeErrorEvent(exception)),
      expect: () => [
        equals(HomeLoaded(images)),
        equals(HomeError(exception)),
        equals(const HomeLoaded(['test', 'test', 'test', 'test'])),
      ],
    );
  });
}
