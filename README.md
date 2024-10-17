Advanced value notifier package gives notifiers some extra capabilities.

## Features
* Build specific UI part based on some condition using buildWhen
* Listen to the specific value based on some condition listenWhen
* Transform values in notifier
* Optimally show data in UI by using previously available value and current value.

## Usage

### AdvancedValueListenableListener
```dart
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
```

### AdvancedValueListenableBuilder
```dart
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
```

### HistoryValueListenableListener
```dart
    HistoryValueListenableListener<int>(
      historyValueListenable: counter,
      historyValueWidgetListener: (int? prevValue, int value) {
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
      historyValueListenable: counter,
      historyValueBuilder: (BuildContext context, int? prevValue,
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
      transformerHistoryValueListenable: transformerHistoryValueNotifier,
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
    )
```

### TransformerHistoryValueListenableListener
```dart
    TransformerHistoryValueListenableListener<int, int>(
      transformerHistoryValueListenable: transformerHistoryValueNotifier,
      transformerHistoryValueWidgetListener: (
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
    )
```

## Additional information

Connect with Author over [Linkedin](https://www.linkedin.com/in/abhishakkrmalviya/)
