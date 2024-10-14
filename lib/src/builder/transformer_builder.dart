import 'package:advanced_value_notifier/src/notifiers/transformed_notifier.dart';
import 'package:flutter/widgets.dart';

typedef TransformerHistoryValueWidgetBuilder<T, U> = Widget Function(
  BuildContext context,
  T? prevValue,
  U? prevTransformedValue,
  T value,
  U transformedValue,
  Widget? child,
);

class TransformedHistoryValueListenableBuilder<T, U> extends StatefulWidget {
  const TransformedHistoryValueListenableBuilder({
    super.key,
    required this.historyValueNotifier,
    required this.historyValueBuilder,
    this.child,
  });

  final TransformerHistoryValueNotifier<T, U> historyValueNotifier;

  final TransformerHistoryValueWidgetBuilder<T, U> historyValueBuilder;

  final Widget? child;

  @override
  State<StatefulWidget> createState() =>
      _TransformedHistoryValueListenableBuilderState<T, U>();
}

class _TransformedHistoryValueListenableBuilderState<T, U>
    extends State<TransformedHistoryValueListenableBuilder<T, U>> {
  late T value;
  late U transformedValue;
  T? prevValue;
  U? prevTransformedValue;

  @override
  void initState() {
    super.initState();
    value = widget.historyValueNotifier.value;
    transformedValue = widget.historyValueNotifier.transformedValue;
    widget.historyValueNotifier.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(
      TransformedHistoryValueListenableBuilder<T, U> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.historyValueNotifier != widget.historyValueNotifier) {
      oldWidget.historyValueNotifier.removeListener(_valueChanged);
      value = widget.historyValueNotifier.value;
      transformedValue = widget.historyValueNotifier.transformedValue;
      prevValue = widget.historyValueNotifier.prevValue;
      prevTransformedValue = widget.historyValueNotifier.prevTransformedValue;
      widget.historyValueNotifier.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.historyValueNotifier.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    setState(() {
      value = widget.historyValueNotifier.value;
      prevValue = widget.historyValueNotifier.prevValue;
      transformedValue = widget.historyValueNotifier.transformedValue;
      prevTransformedValue = widget.historyValueNotifier.prevTransformedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.historyValueBuilder(
      context,
      prevValue,
      prevTransformedValue,
      value,
      transformedValue,
      widget.child,
    );
  }
}
