import 'package:advanced_value_notifier/src/condition/simple.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef ValueListener<T> = void Function(T value);

class AdvancedValueListenableListener<T> extends StatefulWidget {
  const AdvancedValueListenableListener({
    super.key,
    required this.valueListenable,
    required this.listener,
    required this.child,
    this.listenWhen,
  });

  final ValueListenable<T> valueListenable;

  final ValueListener<T> listener;

  final ValueCondition<T>? listenWhen;

  final Widget child;

  @override
  State<StatefulWidget> createState() =>
      _AdvancedValueListenableListenerState<T>();
}

class _AdvancedValueListenableListenerState<T>
    extends State<AdvancedValueListenableListener<T>> {
  @override
  void initState() {
    super.initState();
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(AdvancedValueListenableListener<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    T tempValue = widget.valueListenable.value;
    if (widget.listenWhen?.call(tempValue) ?? true) {
      widget.listener(tempValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
