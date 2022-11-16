import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:matchfee/coffee/coffe.dart';
import 'package:matchfee/repo.dart';

class MatchesCubit extends Cubit<List<Coffee>> {
  MatchesCubit({
    required CoffeeRepository coffeeRepository,
  })  : _coffeeRepository = coffeeRepository,
        super([]) {
    _coffeeSubscription = _coffeeRepository.getDeviceCoffees().listen(
      (event) {
        print('a');
        // state
        emit(event);
      },
    );
  }

  final CoffeeRepository _coffeeRepository;
  late final StreamSubscription<List<Coffee>> _coffeeSubscription;

  @override
  Future<void> close() async {
    await _coffeeSubscription.cancel();
    await super.close();
  }
}
