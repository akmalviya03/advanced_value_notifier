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
  final TransformerHistoryValueNotifier<int, int>
      transformerHistoryValueNotifier =
      TransformerHistoryValueNotifier<int, int>(
    value: 0,
    transformer: (value) {
      return value % 2;
    },
  );
  final ValueNotifier<int> valueNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AdvancedValueListenableListener<int>(
              valueListenable: valueNotifier,
              listener: (value) {
                print("Advanced Value listener $value");
              },
              listenWhen: (int value) {
                if (value.isEven) {
                  return true;
                }
                return false;
              },
              child: const Text("Advanced Value Listenable"),
            ),
            AdvancedValueListenableBuilder(
              valueListenable: valueNotifier,
              buildWhen: (int value) {
                if (value.isEven) {
                  return true;
                }
                return false;
              },
              builder: (BuildContext context, int value, Widget? child) {
                return Text("$value");
              },
            ),
            HistoryValueListenableListener<int>(
              historyValueListenable: counter,
              historyValueListener: (int? prevValue, int value) {
                ScaffoldMessenger.of(context).clearMaterialBanners();
                ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                    content: Text("Simple Prev $prevValue Curr $value"),
                    actions: [
                      GestureDetector(
                        child: const Text("Cancel"),
                        onTap: () {
                          ScaffoldMessenger.of(context).clearMaterialBanners();
                        },
                      )
                    ]));
              },
              child: const Text(
                'Simple Listener',
              ),
            ),
            HistoryValueListenableBuilder<int>(
              historyValueListenable: counter,
              historyValueBuilder: (BuildContext context, int? prevValue,
                  int value, Widget? child) {
                return Text(
                  "Prev $prevValue Curr $value",
                );
              },
            ),
            TransformerHistoryValueListenableBuilder<int, int>(
              transformerHistoryValueListenable:
                  transformerHistoryValueNotifier,
              transformerHistoryValueBuilder: (BuildContext context,
                  int? prevValue,
                  int? prevTransformedValue,
                  int value,
                  int transformedValue,
                  Widget? child) {
                return Text(
                  "Prev $prevValue PrevTransformed $prevTransformedValue Curr $value Transformed $transformedValue",
                );
              },
            ),
            TransformerHistoryValueListenableListener<int, int>(
              transformerHistoryValueListenable:
                  transformerHistoryValueNotifier,
              transformerHistoryValueListener: (
                int? prevValue,
                int? prevTransformedValue,
                int value,
                int transformedValue,
              ) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  "Prev $prevValue PrevTransformed $prevTransformedValue "
                  "Curr $value Transformed $transformedValue",
                )));
              },
              child: const Text(
                "Transformer Listener",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.value++;
          transformerHistoryValueNotifier.value++;
          valueNotifier.value++;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
