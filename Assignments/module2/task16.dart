import 'dart:io';
void main()
{
  Map<String, String> addressBook = {};

  while (true) {
    print("\n--- Address Book Menu ---");
    print("1. Add Contact");
    print("2. Update Contact");
    print("3. Remove Contact");
    print("4. View Contacts");
    print("5. Exit");
    stdout.write("Enter your choice: ");

    int choice = int.parse(stdin.readLineSync()!);

    switch (choice)
    {
      case 1:
        stdout.write("Enter name: ");
        String name = stdin.readLineSync()!;
        stdout.write("Enter phone number: ");
        String phone = stdin.readLineSync()!;
        addressBook[name] = phone;
        print("Contact added successfully!");
        break;

      case 2:
        stdout.write("Enter name to update: ");
        String updateName = stdin.readLineSync()!;
        if (!addressBook.containsKey(updateName)
        {
          stdout.write("Enter new phone number: ");
          addressBook[updateName] = stdin.readLineSync()!;
          print("Contact updated successfully!");
        }
        else {
          print("Contact not found!");
        }
        break;

      case 3:
        stdout.write("Enter name to remove: ");
        String removeName = stdin.readLineSync()!;
        if (addressBook.remove(removeName) != null)
        {
          print("Contact removed successfully!");
        } else {
          print("Contact not found!");
        }
        break;

      case 4:
        if (addressBook.isEmpty) {
          print("Address Book is empty.");
        } else {
          print("\n--- Contacts ---");
          addressBook.forEach((name, phone) {
            print("$name : $phone");
          });
        }
        break;

      case 5:
        print("Exiting Address Book...");
        return;

      default:
        print("Invalid choice! Try again.");
    }
  }
}
