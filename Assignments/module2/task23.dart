import 'dart:io';
void main()
{
  double num1 = getNumber("Enter first number: ");
  double num2 = getNumber("Enter second number: ");
  print("Sum = ${num1 + num2}");
  print("Difference = ${num1 - num2}");
  print("Product = ${num1 * num2}");
  if (num2 != 0)
  {
    print("Quotient = ${num1 / num2}");
  } else
  {
    print("Cannot divide by zero");
  }
}
double getNumber(String message)
{
  while (true)
  {
    try
    {
      stdout.write(message);
      return double.parse(stdin.readLineSync()!);
    } catch (e)
    {
      print("Invalid input! Please enter a number.");
    }
  }
}
