import 'dart:async';

void main() async {
  await for (int value in numberStream(5)) {
    print(value);
  }
}

Stream<int> numberStream(int count) async* {
  for (int i = 1; i <= count; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}
