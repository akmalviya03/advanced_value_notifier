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
        print("Prev $prevValue Curr $value");
      },
      child: const Text(
        'Hello',
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
          style: Theme.of(context).textTheme.headlineMedium,
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
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
    ),
```

## Additional information

Connect with Author over [Linkedin](https://www.linkedin.com/in/abhishakkrmalviya/)
