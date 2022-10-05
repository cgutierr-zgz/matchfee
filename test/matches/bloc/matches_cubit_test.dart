import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('MatchesCubit', () {
    late MatchesCubit matchesCubit;

    setUp(() {
      matchesCubit = buildMatchesCubit();
    });

    test('initial state is empty', () {
      expect(matchesCubit.state, equals([]));
    });

    blocTest<MatchesCubit, List<String>>(
      'Adds a new matchee',
      build: buildMatchesCubit,
      act: (cubit) => cubit.addMatch('image1.png'),
      expect: () => [
        equals(['image1.png'])
      ],
    );

    blocTest<MatchesCubit, List<String>>(
      'Adds multiple matchees',
      build: buildMatchesCubit,
      act: (cubit) {
        cubit
          ..addMatch('image1.png')
          ..addMatch('image2.png');
      },
      expect: () => [
        equals(['image2.png', 'image1.png']),
        equals(['image2.png', 'image1.png'])
      ],
    );

    blocTest<MatchesCubit, List<String>>(
      'Removes a matchee',
      build: buildMatchesCubit,
      act: (cubit) {
        cubit
          ..addMatch('image1.png')
          ..addMatch('image2.png')
          ..deleteMatch('image1.png')
          ..deleteMatch('image2.png');
      },
      expect: () => [
        equals(['image2.png', 'image1.png']),
        equals(['image2.png']),
        equals([]),
        equals([]),
      ],
    );
  });
}
