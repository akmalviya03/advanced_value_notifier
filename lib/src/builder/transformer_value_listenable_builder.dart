import 'package:advanced_value_notifier/src/condition/transformer.dart';
import 'package:advanced_value_notifier/src/notifiers/transformer_history_value_listenable.dart';
import 'package:flutter/widgets.dart';

typedef TransformerHistoryValueWidgetBuilder<T, U> = Widget Function(
  BuildContext context,
  T? prevValue,
  U? prevTransformedValue,
  T curr,
  U currTransformedValue,
  Widget? child,
);

class TransformerHistoryValueListenableBuilder<T, U> extends StatefulWidget {
  const TransformerHistoryValueListenableBuilder(
      {super.key,
      required this.transformerHistoryValueListenable,
      required this.transformerHistoryValueBuilder,
      this.child,
      this.buildWhen});

  final TransformerHistoryValueListenable<T, U>
      transformerHistoryValueListenable;

  final TransformerHistoryValueWidgetBuilder<T, U>
      transformerHistoryValueBuilder;

  final Widget? child;

  final TransformerHistoryValueCondition<T, U>? buildWhen;

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
    value = widget.transformerHistoryValueListenable.value;
    transformedValue =
        widget.transformerHistoryValueListenable.transformedValue;
    widget.transformerHistoryValueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(
      TransformerHistoryValueListenableBuilder<T, U> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.transformerHistoryValueListenable !=
        widget.transformerHistoryValueListenable) {
      oldWidget.transformerHistoryValueListenable.removeListener(_valueChanged);
      value = widget.transformerHistoryValueListenable.value;
      transformedValue =
          widget.transformerHistoryValueListenable.transformedValue;
      prevValue = widget.transformerHistoryValueListenable.prevValue;
      prevTransformedValue =
          widget.transformerHistoryValueListenable.prevTransformedValue;
      widget.transformerHistoryValueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.transformerHistoryValueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    T? tempPrev = widget.transformerHistoryValueListenable.prevValue;
    U? tempPrevTransformedValue =
        widget.transformerHistoryValueListenable.prevTransformedValue;

    T tempValue = widget.transformerHistoryValueListenable.value;
    U tempTransformedValue =
        widget.transformerHistoryValueListenable.transformedValue;

    if (widget.buildWhen?.call(tempPrev, tempPrevTransformedValue, tempValue,
            tempTransformedValue) ??
        true) {
      setState(() {
        value = tempValue;
        prevValue = tempPrev;
        transformedValue = tempTransformedValue;
        prevTransformedValue = tempPrevTransformedValue;
      });
    }
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
