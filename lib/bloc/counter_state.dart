abstract class CounterState {
  int count;

  CounterState(this.count);
}

class Initial extends CounterState {
  Initial(int count) : super(count);
}

class Added extends CounterState {
  Added(int count) : super(count);
}

class Decreased extends CounterState {
  Decreased(int count) : super(count);
}

class Reset extends CounterState {
  Reset(int count) : super(count);
}
