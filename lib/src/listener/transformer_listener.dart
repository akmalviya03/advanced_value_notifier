import 'package:advanced_value_notifier/src/notifiers/transformer_notifier.dart';
import 'package:flutter/material.dart';

typedef TransformerHistoryValueWidgetListener<T, U> = void Function(
  T? prevValue,
  U? prevTransformedValue,
  T value,
  U transformedValue,
);

class TransformerHistoryValueListenableListener<T, U> extends StatefulWidget {
  const TransformerHistoryValueListenableListener({
    super.key,
    required this.transformerHistoryValueWidgetListener,
    required this.transformerHistoryValueNotifier,
    required this.child,
  });

  final TransformerHistoryValueNotifier<T, U> transformerHistoryValueNotifier;

  final TransformerHistoryValueWidgetListener<T, U>
      transformerHistoryValueWidgetListener;

  final Widget child;

  @override
  State<StatefulWidget> createState() =>
      _TransformerHistoryValueListenableListenerState<T, U>();
}

class _TransformerHistoryValueListenableListenerState<T, U>
    extends State<TransformerHistoryValueListenableListener<T, U>> {
  @override
  void initState() {
    super.initState();
    widget.transformerHistoryValueNotifier.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(
      TransformerHistoryValueListenableListener<T, U> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.transformerHistoryValueNotifier !=
        widget.transformerHistoryValueNotifier) {
      oldWidget.transformerHistoryValueNotifier.removeListener(_valueChanged);
      widget.transformerHistoryValueNotifier.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.transformerHistoryValueNotifier.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    widget.transformerHistoryValueWidgetListener(
        widget.transformerHistoryValueNotifier.prevValue,
        widget.transformerHistoryValueNotifier.prevTransformedValue,
        widget.transformerHistoryValueNotifier.value,
        widget.transformerHistoryValueNotifier.transformedValue);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
