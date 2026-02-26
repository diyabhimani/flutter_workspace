import 'dart:io';

void main() {
  String filePath = "sample.txt";

  try {
    File file = File(filePath);
    String contents = file.readAsStringSync();
    print("File Contents:\n$contents");
  } catch (e) {
    print("Error: File not found or cannot be read.");
  }
}
