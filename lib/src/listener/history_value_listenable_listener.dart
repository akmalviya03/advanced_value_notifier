import 'package:advanced_value_notifier/src/condition/history.dart';
import 'package:advanced_value_notifier/src/notifiers/history_value_listenable.dart';
import 'package:flutter/material.dart';

typedef HistoryValueListener<T> = void Function(T? prev, T curr);

class HistoryValueListenableListener<T> extends StatefulWidget {
  const HistoryValueListenableListener({
    super.key,
    required this.historyValueListener,
    required this.historyValueListenable,
    required this.child,
    this.listenWhen,
  });

  final HistoryValueListenable<T> historyValueListenable;

  final HistoryValueListener<T> historyValueListener;

  final Widget child;

  final HistoryValueCondition<T>? listenWhen;

  @override
  State<StatefulWidget> createState() =>
      _HistoryValueListenableListenerState<T>();
}

class _HistoryValueListenableListenerState<T>
    extends State<HistoryValueListenableListener<T>> {
  @override
  void initState() {
    super.initState();
    widget.historyValueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(HistoryValueListenableListener<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.historyValueListenable != widget.historyValueListenable) {
      oldWidget.historyValueListenable.removeListener(_valueChanged);
      widget.historyValueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.historyValueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    T tempValue = widget.historyValueListenable.value;
    T? tempPrev = widget.historyValueListenable.prevValue;
    if (widget.listenWhen?.call(tempPrev, tempValue) ?? true) {
      widget.historyValueListener(tempPrev, tempValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
