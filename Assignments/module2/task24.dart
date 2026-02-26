import 'dart:io';
void main()
{
  List<int> numbers = [];
  print("Enter 5 integers:");
  while (numbers.length < 5)
  {
    try
    {
      stdout.write("Enter number ${numbers.length + 1}: ");
      int value = int.parse(stdin.readLineSync()!);
      numbers.add(value);
    } catch (e)
    {
      print("Invalid input! Please enter an integer.");
    }
  }

  print("You entered: $numbers");
}
