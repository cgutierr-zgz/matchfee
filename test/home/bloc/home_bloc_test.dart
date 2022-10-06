import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:matchfee/home/home.dart';

import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Home Bloc', () {
    late HomeBloc homeBloc;
    late MatchesCubit matchesCubit;
    final exception = Exception('error');
    final images = ['image1', 'image2'];

    setUp(() {
      matchesCubit = buildMatchesCubit();
      homeBloc = HomeBloc(
        matchesCubit: matchesCubit,
        homeRepository: HomeRepository(
          client: MockClient(
            (request) async {
              return Response('{"file":  "test"}', 200);
            },
          ),
        ),
      );
    });

    test('initial state is empty', () {
      expect(homeBloc.state, equals(const HomeLoading()));
    });

    blocTest<HomeBloc, HomeState>(
      'Adds new matchees to the array (mock images)',
      build: () => homeBloc,
      act: (bloc) => bloc.add(HomeStartEvent(images)),
      expect: () => [
        equals(HomeLoaded(images)),
        // Emits 'test' because thats the name we gave in the mock client
        equals(const HomeLoaded(['test', 'test', 'test', 'test'])),
      ],
    );

/* 
  * Having trouble testing the saveImage to device...

  So i can't relly test the  NextHomeEvent.like and NextHomeEvent.superLike :/

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
        equals(const HomeLoaded(['image2', 'test'])),
        equals(const HomeLoading()),
        equals(const HomeLoaded(['image2', 'test'])),
        equals(const HomeLoaded(['test', 'test', 'test', 'test'])),
      ],
    );
    blocTest<HomeBloc, HomeState>(
      'Dislikes the given matchee and goes back',
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
        equals(const HomeLoaded(['image2', 'test'])),
        equals(const HomeLoading()),
        equals(const HomeLoaded(['image2', 'test'])),
        equals(const HomeLoading()),
        equals(const HomeLoaded(['image2', 'test'])),
        equals(const HomeLoaded(['test', 'test', 'test', 'test'])),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'Adds an error',
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
