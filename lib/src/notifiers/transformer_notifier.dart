import 'package:flutter/foundation.dart';

class TransformerHistoryValueNotifier<T, U> extends ChangeNotifier {
  TransformerHistoryValueNotifier({required T value, required this.transformer})
      : _value = value,
        _transformedValue = transformer(value) {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  T get value => _value;
  T _value;

  U _transformedValue;
  U get transformedValue => _transformedValue;

  T? _prevValue;
  T? get prevValue => _prevValue;

  U? _prevTransformedValue;
  U? get prevTransformedValue => _prevTransformedValue;

  U Function(T value) transformer;

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
  String toString() => '${describeIdentity(this)}($prevValue)($value)';
}
