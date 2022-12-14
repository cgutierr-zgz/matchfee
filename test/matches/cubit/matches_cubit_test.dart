import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('MatchesCubit', () {
    late MatchesCubit matchesCubit;
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit();
    });

    const coffeeSample = SavedCoffee(
      imagePath: 'image1.png',
      superLike: true,
    );
    const coffeeSample2 = SavedCoffee(
      imagePath: 'image2.png',
      superLike: false,
    );

    test('initial state is empty', () {
      expect(matchesCubit.state, equals([]));
    });

    blocTest<MatchesCubit, List<SavedCoffee>>(
      'Adds a new matchee',
      build: buildMatchesCubit,
      act: (cubit) => cubit.addMatch(
        coffeeSample.imagePath,
        isSuperLike: coffeeSample.superLike,
      ),
      expect: () => [
        equals([coffeeSample])
      ],
    );

    blocTest<MatchesCubit, List<SavedCoffee>>(
      'Adds multiple matchees',
      build: buildMatchesCubit,
      act: (cubit) {
        cubit
          ..addMatch(
            coffeeSample.imagePath,
            isSuperLike: coffeeSample.superLike,
          )
          ..addMatch(
            coffeeSample2.imagePath,
            isSuperLike: coffeeSample2.superLike,
          );
      },
      expect: () => [
        equals([coffeeSample2, coffeeSample]),
        equals([coffeeSample2, coffeeSample])
      ],
    );

    blocTest<MatchesCubit, List<SavedCoffee>>(
      'Removes a matchee',
      build: buildMatchesCubit,
      act: (cubit) {
        cubit
          ..addMatch(
            coffeeSample.imagePath,
            isSuperLike: coffeeSample.superLike,
          )
          ..addMatch(
            coffeeSample2.imagePath,
            isSuperLike: coffeeSample2.superLike,
          )
          ..deleteMatch('image1.png')
          ..deleteMatch('image2.png');
      },
      expect: () => [
        equals([coffeeSample2, coffeeSample]),
        equals([coffeeSample2]),
        equals([]),
        equals([]),
      ],
    );

    blocTest<MatchesCubit, List<SavedCoffee>>(
      'Wipes the data',
      build: buildMatchesCubit,
      act: (cubit) {
        cubit
          ..addMatch(
            coffeeSample.imagePath,
            isSuperLike: coffeeSample.superLike,
          )
          ..addMatch(
            coffeeSample2.imagePath,
            isSuperLike: coffeeSample2.superLike,
          )
          ..wipeData();
      },
      expect: () => [
        equals([coffeeSample2, coffeeSample]),
        equals([coffeeSample2, coffeeSample]),
        equals([]),
      ],
    );

    /*
    * I don't really know how to test the storage part of the cubit

    late Storage storage;
    late MatchesCubit cubit;
    setUp(() {
      storage = MockStorage();
      cubit = buildMatchesCubit(storage);
    });

    test('writes and reads', () {
      cubit.addMatch(
        coffeeSample.imagePath,
        isSuperLike: coffeeSample.superLike,
      );
      verify<dynamic>(() => storage.read('')).called(1);
    });
    */
  });
}
