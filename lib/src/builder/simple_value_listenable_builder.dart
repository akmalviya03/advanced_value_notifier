import 'package:advanced_value_notifier/src/condition/simple.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AdvancedValueListenableBuilder<T> extends StatefulWidget {
  const AdvancedValueListenableBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
    this.child,
    this.buildWhen,
  });

  final ValueListenable<T> valueListenable;

  final ValueWidgetBuilder<T> builder;

  final ValueCondition<T>? buildWhen;

  final Widget? child;

  @override
  State<StatefulWidget> createState() =>
      _AdvancedValueListenableBuilderState<T>();
}

class _AdvancedValueListenableBuilderState<T>
    extends State<AdvancedValueListenableBuilder<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(AdvancedValueListenableBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    T tempValue = widget.valueListenable.value;

    if (widget.buildWhen?.call(tempValue) ?? true) {
      setState(() {
        value = widget.valueListenable.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }
}
