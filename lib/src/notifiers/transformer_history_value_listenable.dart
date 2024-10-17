import 'package:advanced_value_notifier/src/notifiers/history_value_listenable.dart';

abstract class TransformerHistoryValueListenable<T, U>
    extends HistoryValueListenable<T> {
  const TransformerHistoryValueListenable({required this.transformer});

  U get transformedValue;

  U? get prevTransformedValue;

  final U Function(T value) transformer;
}
