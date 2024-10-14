import 'package:advanced_value_notifier/src/notifier.dart';
import 'package:flutter/widgets.dart';

typedef HistoryValueWidgetBuilder<T> = Widget Function(
    BuildContext context, T prevValue, T value, Widget? child);

class HistoryValueListenableBuilder<T> extends StatefulWidget {
  const HistoryValueListenableBuilder({
    super.key,
    required this.historyValueNotifier,
    required this.historyValueBuilder,
    this.child,
  });

  final HistoryValueNotifier<T> historyValueNotifier;

  final HistoryValueWidgetBuilder<T> historyValueBuilder;

  final Widget? child;

  @override
  State<StatefulWidget> createState() =>
      _HistoryValueListenableBuilderState<T>();
}

class _HistoryValueListenableBuilderState<T>
    extends State<HistoryValueListenableBuilder<T>> {
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
  void didUpdateWidget(HistoryValueListenableBuilder<T> oldWidget) {
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
    setState(() {
      value = widget.historyValueNotifier.value;
      prevValue = widget.historyValueNotifier.prevValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.historyValueBuilder(context, prevValue, value, widget.child);
  }
}
