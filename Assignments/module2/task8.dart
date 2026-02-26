import 'dart:io';

void main() {
  print("enter a number");
  double a = double.parse(stdin.readLineSync().toString());

  print("enter second  number");
  double b = double.parse(stdin.readLineSync().toString());

  print("select  1:add , 2:sub,3:mul,4:div");
  double choice = double.parse(stdin.readLineSync().toString());
  
  switch (choice) {
    case 1:

        print("add=$a+$b");
    case 2:

        print("sub=$a-$b");

    case 3:

        print("mul=$a*$b");

    case 4:

        if(b%2 !=0)
          {
            print("div=$a~/$b");
          }
        else
          {
            print("0 is not divisible");
          }

    default:
     print("invalid");


  }
}