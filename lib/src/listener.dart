import 'package:advanced_value_notifier/advanced_value_notifier.dart';
import 'package:flutter/material.dart';

typedef HistoryValueWidgetListener<T> = void Function(T prev, T curr);

class HistoryValueListenableListener<T> extends StatefulWidget {
  const HistoryValueListenableListener({
    super.key,
    required this.historyValueWidgetListener,
    required this.historyValueNotifier,
    required this.child,
  });

  final HistoryValueNotifier<T> historyValueNotifier;

  final HistoryValueWidgetListener<T> historyValueWidgetListener;

  final Widget child;

  @override
  State<StatefulWidget> createState() =>
      _HistoryValueListenableListenerState<T>();
}

class _HistoryValueListenableListenerState<T>
    extends State<HistoryValueListenableListener<T>> {
  late T value;
  late T prevValue;

  @override
  void initState() {
    super.initState();
    value = widget.historyValueNotifier.value;
    prevValue = widget.historyValueNotifier.prevValue;
    widget.historyValueNotifier.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(HistoryValueListenableListener<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.historyValueNotifier != widget.historyValueNotifier) {
      oldWidget.historyValueNotifier.removeListener(_valueChanged);
      value = widget.historyValueNotifier.value;
      prevValue = widget.historyValueNotifier.prevValue;
      widget.historyValueNotifier.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.historyValueNotifier.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    widget.historyValueWidgetListener(widget.historyValueNotifier.prevValue,
        widget.historyValueNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
