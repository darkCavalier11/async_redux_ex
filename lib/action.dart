import 'dart:async';
import 'dart:convert';

import 'package:async_redux/async_redux.dart';

class Counter {
  final int counter;
  Counter({
    required this.counter,
  });

  int increment(int amount) {
    return counter + amount;
  }

  

  Counter copyWith({
    int? counter,
  }) {
    return Counter(
      counter: counter ?? this.counter,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'counter': counter,
    };
  }

  factory Counter.fromMap(Map<String, dynamic> map) {
    return Counter(
      counter: map['counter'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Counter.fromJson(String source) => Counter.fromMap(json.decode(source));

  @override
  String toString() => 'Counter(counter: $counter)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Counter &&
      other.counter == counter;
  }

  @override
  int get hashCode => counter.hashCode;
}

