import 'dart:io';

void main()
{

  print("enter a name" );
  var name =stdin.readLineSync().toString();
  print("enter your age");
  int age =int.parse(stdin.readLineSync().toString());

  int b= 100;
  b -= age;

  print("welcome $name and $b years is left for turning 100years");



}