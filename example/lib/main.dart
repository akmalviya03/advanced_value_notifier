import 'package:advanced_value_notifier/advanced_value_notifier.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleValueListenableListener());
}

class ExampleValueListenableListener extends StatelessWidget {
  const ExampleValueListenableListener({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'History Value Notifier'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  final HistoryValueNotifier<int> counter = HistoryValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HistoryValueListenableListener<int>(
              historyValueNotifier: counter,
              historyValueWidgetListener: (int prevValue, int value) {
                print("Prev $prevValue Curr $value");
              },
              child: const Text(
                'Hello',
              ),
            ),
            HistoryValueListenableBuilder<int>(
              historyValueNotifier: counter,
              historyValueBuilder: (BuildContext context, int prevValue,
                  int value, Widget? child) {
                return Text(
                  "Prev $prevValue Curr $value",
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.value++;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
