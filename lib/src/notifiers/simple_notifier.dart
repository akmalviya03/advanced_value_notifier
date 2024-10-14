import 'package:flutter/foundation.dart';

class HistoryValueNotifier<T> extends ChangeNotifier {
  HistoryValueNotifier(this._value) : _prevValue = _value {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  T get value => _value;
  T _value;

  T _prevValue;
  T get prevValue => _prevValue;

  set value(T newValue) {
    if (_value == newValue) {
      return;
    }
    _prevValue = value;
    _value = newValue;
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($prevValue)($value)';
}
