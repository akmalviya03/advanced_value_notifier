import 'package:advanced_value_notifier/src/notifiers/transformer_notifier.dart';
import 'package:flutter/widgets.dart';

typedef TransformerHistoryValueWidgetBuilder<T, U> = Widget Function(
  BuildContext context,
  T? prevValue,
  U? prevTransformedValue,
  T value,
  U transformedValue,
  Widget? child,
);

class TransformerHistoryValueListenableBuilder<T, U> extends StatefulWidget {
  const TransformerHistoryValueListenableBuilder({
    super.key,
    required this.transformerHistoryValueNotifier,
    required this.transformerHistoryValueBuilder,
    this.child,
  });

  final TransformerHistoryValueNotifier<T, U> transformerHistoryValueNotifier;

  final TransformerHistoryValueWidgetBuilder<T, U>
      transformerHistoryValueBuilder;

  final Widget? child;

  @override
  State<StatefulWidget> createState() =>
      _TransformerHistoryValueListenableBuilderState<T, U>();
}

class _TransformerHistoryValueListenableBuilderState<T, U>
    extends State<TransformerHistoryValueListenableBuilder<T, U>> {
  late T value;
  late U transformedValue;
  T? prevValue;
  U? prevTransformedValue;

  @override
  void initState() {
    super.initState();
    value = widget.transformerHistoryValueNotifier.value;
    transformedValue = widget.transformerHistoryValueNotifier.transformedValue;
    widget.transformerHistoryValueNotifier.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(
      TransformerHistoryValueListenableBuilder<T, U> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.transformerHistoryValueNotifier !=
        widget.transformerHistoryValueNotifier) {
      oldWidget.transformerHistoryValueNotifier.removeListener(_valueChanged);
      value = widget.transformerHistoryValueNotifier.value;
      transformedValue =
          widget.transformerHistoryValueNotifier.transformedValue;
      prevValue = widget.transformerHistoryValueNotifier.prevValue;
      prevTransformedValue =
          widget.transformerHistoryValueNotifier.prevTransformedValue;
      widget.transformerHistoryValueNotifier.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.transformerHistoryValueNotifier.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    setState(() {
      value = widget.transformerHistoryValueNotifier.value;
      prevValue = widget.transformerHistoryValueNotifier.prevValue;
      transformedValue =
          widget.transformerHistoryValueNotifier.transformedValue;
      prevTransformedValue =
          widget.transformerHistoryValueNotifier.prevTransformedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.transformerHistoryValueBuilder(
      context,
      prevValue,
      prevTransformedValue,
      value,
      transformedValue,
      widget.child,
    );
  }
}
