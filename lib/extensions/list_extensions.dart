extension ListExtension<T> on List<T> {
  num sumBy(num Function(T element) f) {
    num sum = 0;
    for (final element in this) {
      sum += f(element);
    }
    return sum;
  }
}

extension ListStringExtension on List<String> {
  String separarComVirgulas() {
    var splitted = join(', ');

    return splitted;
  }
}
