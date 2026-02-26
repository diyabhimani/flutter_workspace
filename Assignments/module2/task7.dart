import 'dart:io';
void main() {
  print("enter a number");
  int num= int.parse(stdin.readLineSync().toString());
   int x = 0;

    for (int i = 1; i <= num; i++) {
      if (num % i == 0) {
        x++;
      }
    }

    if (x == 2) {
      print("$num is a prime number");
    } else {
      print("$num is not a prime number");
    }
  }
