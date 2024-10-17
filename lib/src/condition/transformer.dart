typedef TransformerHistoryValueCondition<T, U> = bool Function(
  T? prevValue,
  U? prevTransformedValue,
  T curr,
  U currTransformedValue,
);
