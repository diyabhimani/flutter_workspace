//Write a function to calculate the factorial of a number entered by the user
import 'dart:io';
void factorial()
{
    print("Enter a number:");
    int n = int.parse(stdin.readLineSync().toString());
    int fact = 1;

    for (int i = 1; i <= n; i++)
    {
      fact *= i;
    }
    print("Factorial of $n is $fact");

}
void main()
{
  factorial();
}