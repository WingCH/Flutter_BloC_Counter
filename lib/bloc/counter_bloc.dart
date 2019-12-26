import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int _initCount = 0;

  @override
  CounterState get initialState => Initial(_initCount);

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is Add) {
      _initCount++;
      yield Added(_initCount);
    } else if (event is Remove) {
      _initCount--;
      yield Decreased(_initCount);
    } else if (event is Refresh) {
      _initCount = 0;
      yield Reset(_initCount);
    }
  }
}
