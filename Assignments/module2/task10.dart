//Create a function that checks if a string is a palindrome (reads the same backward as forward).
import 'dart:io';
bool palindrome(String str) {
  int start = 0;
  int end = str.length - 1;

  while (start < end) {
    if (str[start] != str[end]) {
      return false;
    }
    start++;
    end--;
  }
  return true;
}

void main() {
  String word = "diya";

  if (palindrome(word)) {
    print("$word is a palindrome");
  } else {
    print("$word is not a palindrome");
  }
}
