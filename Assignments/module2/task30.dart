void main() {
  List<int> numbers = [2, 4, 6, 8];

  var squares = applyOperation(numbers, (n) => n * n);
  var cubes = applyOperation(numbers, (n) => n * n * n);
  var halves = applyOperation(numbers, (n) => n / 2);

  print("Squares: $squares");
  print("Cubes: $cubes");
  print("Halves: $halves");
}

List<T> applyOperation<T>(
    List<int> numbers, T Function(int) operation) {
  return numbers.map(operation).toList();
}
