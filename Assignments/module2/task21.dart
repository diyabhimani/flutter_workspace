import 'dart:io';
void main()
{
  print('Enter first number:');
  int a = int.parse(stdin.readLineSync()!);
  print('Enter second number:');
  int b = int.parse(stdin.readLineSync()!);
  try
  {
    int result = a ~/ b;
    print('Result: $result');
  }
  catch (e)
  {
    print('Error: Division by zero is not allowed');
  }
}
