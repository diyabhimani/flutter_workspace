void main() {
  String str = "diya";

  Map<String, int> charFrequency = {};

  for (int i = 0; i < str.length; i++) {
    String ch = str[i];

    if (charFrequency.containsKey(ch)) {
      charFrequency[ch] = charFrequency[ch]! + 1;
    } else {
      charFrequency[ch] = 1;
    }
  }

  print("Character Frequencies:");
  charFrequency.forEach((key, value) {
    print("$key : $value");
  });
}
