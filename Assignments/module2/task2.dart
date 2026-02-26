import 'dart:io';
void main()
{
  print("enter  your choice 1:temperature in fahreinheit 2:temperature in celsius ");
  int num =int.parse(stdin.readLineSync().toString());
  switch(num)
  {
    case 1:
      print("enter your temperature in celsius");
      int temperature =int.parse(stdin.readLineSync().toString());


      var F = (temperature * (9~/5) + 32);
      print("temperature in fahreinheit is $F");


    case 2:
      print("enter your temperature in celsius");
      int temperature =int.parse(stdin.readLineSync().toString());

      var C=((temperature-32)*(9~/5));
      print("temperature in celsius is $C");

    default:
      {
        print("invalid choice");
      }
  }


}