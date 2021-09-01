import 'package:async_redux/async_redux.dart';
import 'package:async_redux_ex/action.dart';
import 'package:flutter/material.dart';

late Store<Counter> store;
void main() {
  store = Store<Counter>(initialState: Counter(counter: 0));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<Counter>(
      store: store,
      child: MaterialApp(
        home: MyHomePageConnector(),
      ),
    );
  }
}

class MyHomePageConnector extends StatelessWidget {
  const MyHomePageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<Counter, ViewModel>(
      vm: () => _VmFactory(this),
      builder: (BuildContext context, ViewModel vm) => MyHomePage(
        counter: vm.counter,
        onIncrement: vm.onIncrement,
      ),
    );
  }
}

// View-Model
class _VmFactory extends VmFactory<Counter, MyHomePageConnector> {
  _VmFactory(widget) : super(widget);
  @override
  Vm fromStore() {
    return ViewModel(
        counter: state,
        onIncrement: () async {
          await dispatch(
            IncrementAction(amount: 1),
          );
          print('Hello');
        });
  }
}

class ViewModel extends Vm {
  final Counter counter;
  final VoidCallback onIncrement;

  ViewModel({required this.counter, required this.onIncrement})
      : super(equals: [counter]);
}

// View
class MyHomePage extends StatelessWidget {
  final Counter counter;
  final VoidCallback onIncrement;
  const MyHomePage({Key? key, required this.counter, required this.onIncrement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('$counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onIncrement,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class IncrementAction extends ReduxAction<Counter> {
  final int amount;

  IncrementAction({required this.amount});

  @override
  Future<Counter?> reduce() async {
    await Future.delayed(Duration(seconds: 5));
    return state.copyWith(counter: state.increment(amount));
  }

  @override
  void after() {
    print('Finished');
  }

  @override
  void before() {
    print('Started');
  }
}
