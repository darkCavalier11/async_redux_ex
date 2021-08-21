import 'dart:async';

import 'package:async_redux/async_redux.dart';

class Counter {
  int counter = 0;

  void increment(int amount) {
    counter += amount;
  }
}

