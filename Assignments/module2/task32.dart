import 'dart:io';
import 'dart:math';
void main()
{
  final random = Random();
  int secretNumber = random.nextInt(10) + 1;
  String hint(int guess) =>
      guess > secretNumber ? "Too high!" : "Too low!";
  print(" Number Guessing Game");
  print("Guess a number between 1 and 10");
  while (true)
  {
    stdout.write("Enter your guess: ");
    int guess = int.parse(stdin.readLineSync()!);
    if (guess == secretNumber) {
      print("✅ Correct! You guessed the number.");
      break;
    } else
    {
      print(hint(guess));
    }
  }
}
