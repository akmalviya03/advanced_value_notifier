import 'package:advanced_value_notifier/src/notifiers/transformer_history_value_listenable.dart';
import 'package:flutter/foundation.dart';

class TransformerHistoryValueNotifier<T, U> extends ChangeNotifier
    implements TransformerHistoryValueListenable<T, U> {
  TransformerHistoryValueNotifier({required T value, required this.transformer})
      : _value = value,
        _transformedValue = transformer(value) {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  @override
  T get value => _value;
  T _value;

  U _transformedValue;
  @override
  U get transformedValue => _transformedValue;

  T? _prevValue;
  @override
  T? get prevValue => _prevValue;

  U? _prevTransformedValue;
  @override
  U? get prevTransformedValue => _prevTransformedValue;

  @override
  final U Function(T value) transformer;

  @override
  set value(T newValue) {
    if (_value == newValue) {
      return;
    }
    _prevValue = value;
    _value = newValue;
    _prevTransformedValue = transformedValue;
    _transformedValue = transformer(newValue);
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}prevValue:$prevValue '
      'prevTransformedValue:$prevTransformedValue value:$value '
      'transformedValue:$transformedValue';
}
