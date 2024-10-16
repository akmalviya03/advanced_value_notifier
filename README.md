This package allows you to notify listener about the previous value and current value.

## Features
* Get both previous and current value
* Listen to the value changes
* Build widget optimally by consider previous and current value


## Usage

### HistoryValueListenableListener
```dart
    HistoryValueListenableListener<int>(
      historyValueNotifier: counter,
      historyValueWidgetListener: (int prevValue, int value) {
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
    )
```

### HistoryValueListenableBuilder
```dart
    HistoryValueListenableBuilder<int>(
      historyValueNotifier: counter,
      historyValueBuilder: (BuildContext context, int prevValue,
          int value, Widget? child) {
        return Text(
          "Prev $prevValue Curr $value",
        );
      },
    )
```

### TransformerHistoryValueListenableBuilder
```dart
    TransformerHistoryValueListenableBuilder<int, int>(
      transformerHistoryValueNotifier: transformerHistoryValueNotifier,
      transformerHistoryValueBuilder: (BuildContext context,
          int? prevValue,
          int? prevTransformedValue,
          int value,
          int? transformedValue,
          Widget? child) {
        return Text(
          "Prev $prevValue PrevTransformed $prevTransformedValue Curr $value Transformed $transformedValue",
        );
      },
    )
```

### TransformerHistoryValueListenableListener
```dart
    TransformerHistoryValueListenableListener<int, int>(
      transformerHistoryValueNotifier: transformerHistoryValueNotifier,
      transformerHistoryValueWidgetListener: (
        int? prevValue,
        int? prevTransformedValue,
        int value,
        int? transformedValue,
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
    )
```

## Additional information

Connect with Author over [Linkedin](https://www.linkedin.com/in/abhishakkrmalviya/)
