import 'dart:io';
void main() {
  var pi = 3.14;
  print("enter a radius");
  int radius = int.parse(stdin.readLineSync().toString());
  var area = pi * radius * radius;
  print(" area $area");
  var circumference = 2 * pi * radius;
  print(" circumference $circumference");
}
