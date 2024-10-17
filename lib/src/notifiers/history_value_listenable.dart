import 'package:flutter/foundation.dart';

abstract class HistoryValueListenable<T> extends ValueListenable<T> {
  const HistoryValueListenable();
  @override
  T get value;
  T? get prevValue;
  set value(T newValue);
}
