import 'package:advanced_value_notifier/src/condition/transformer.dart';
import 'package:advanced_value_notifier/src/notifiers/transformer_history_value_listenable.dart';
import 'package:flutter/material.dart';

typedef TransformerHistoryValueListener<T, U> = void Function(
  T? prevValue,
  U? prevTransformedValue,
  T curr,
  U currTransformedValue,
);

class TransformerHistoryValueListenableListener<T, U> extends StatefulWidget {
  const TransformerHistoryValueListenableListener({
    super.key,
    required this.transformerHistoryValueListener,
    required this.transformerHistoryValueListenable,
    required this.child,
    this.listenWhen,
  });

  final TransformerHistoryValueListenable<T, U>
      transformerHistoryValueListenable;

  final TransformerHistoryValueListener<T, U> transformerHistoryValueListener;

  final Widget child;

  final TransformerHistoryValueCondition<T, U>? listenWhen;

  @override
  State<StatefulWidget> createState() =>
      _TransformerHistoryValueListenableListenerState<T, U>();
}

class _TransformerHistoryValueListenableListenerState<T, U>
    extends State<TransformerHistoryValueListenableListener<T, U>> {
  @override
  void initState() {
    super.initState();
    widget.transformerHistoryValueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(
      TransformerHistoryValueListenableListener<T, U> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.transformerHistoryValueListenable !=
        widget.transformerHistoryValueListenable) {
      oldWidget.transformerHistoryValueListenable.removeListener(_valueChanged);
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
    U transformedValue =
        widget.transformerHistoryValueListenable.transformedValue;
    if (widget.listenWhen?.call(
          tempPrev,
          tempPrevTransformedValue,
          tempValue,
          transformedValue,
        ) ??
        true) {
      widget.transformerHistoryValueListener(
        tempPrev,
        tempPrevTransformedValue,
        tempValue,
        transformedValue,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
