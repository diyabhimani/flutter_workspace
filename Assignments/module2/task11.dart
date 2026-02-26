//Write a recursive function to generate the Fibonacci series up to a specified number
import 'dart:io';
void fibonnaci()
{
  print("fibonaaci");
  int n = int.parse(stdin.readLineSync().toString());
  int a = 0, b = 1;
  print("Fibonacci Series:");
  for (int i = 0; i < n; i++)
  {
    print(a);
    int next = a + b;
    a = b;
    b = next;
  }
}
void main()
{
  fibonnaci();
}