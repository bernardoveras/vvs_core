class Resulter<TResult, TError> {
  Resulter._({this.result, this.error});

  final TResult? result;
  final TError? error;

  bool get isSuccess => error == null;
  bool get isError => error != null;

  factory Resulter.success([TResult? result]) => Resulter._(result: result);
  factory Resulter.error(TError error, [TResult? result]) => Resulter._(error: error, result: result);
}