import 'package:advanced_value_notifier/src/notifiers/history_value_listenable.dart';
import 'package:flutter/foundation.dart';

class HistoryValueNotifier<T> extends ChangeNotifier
    implements HistoryValueListenable<T> {
  HistoryValueNotifier(this._value) : _prevValue = _value {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  @override
  T get value => _value;
  T _value;

  T _prevValue;
  @override
  T get prevValue => _prevValue;

  @override
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
