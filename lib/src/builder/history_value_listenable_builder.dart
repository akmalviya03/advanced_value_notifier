import 'package:advanced_value_notifier/src/condition/history.dart';
import 'package:advanced_value_notifier/src/notifiers/history_value_listenable.dart';
import 'package:flutter/widgets.dart';

typedef HistoryValueWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T? prevValue,
  T curr,
  Widget? child,
);

class HistoryValueListenableBuilder<T> extends StatefulWidget {
  const HistoryValueListenableBuilder(
      {super.key,
      required this.historyValueListenable,
      required this.historyValueBuilder,
      this.child,
      this.buildWhen});

  final HistoryValueListenable<T> historyValueListenable;

  final HistoryValueWidgetBuilder<T> historyValueBuilder;

  final Widget? child;

  final HistoryValueCondition<T>? buildWhen;

  @override
  State<StatefulWidget> createState() =>
      _HistoryValueListenableBuilderState<T>();
}

class _HistoryValueListenableBuilderState<T>
    extends State<HistoryValueListenableBuilder<T>> {
  late T value;
  late T? prevValue;

  @override
  void initState() {
    super.initState();
    value = widget.historyValueListenable.value;
    prevValue = widget.historyValueListenable.prevValue;
    widget.historyValueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(HistoryValueListenableBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.historyValueListenable != widget.historyValueListenable) {
      oldWidget.historyValueListenable.removeListener(_valueChanged);
      value = widget.historyValueListenable.value;
      prevValue = widget.historyValueListenable.prevValue;
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
    if (widget.buildWhen?.call(tempPrev, tempValue) ?? true) {
      setState(() {
        value = tempValue;
        prevValue = tempPrev;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.historyValueBuilder(context, prevValue, value, widget.child);
  }
}
