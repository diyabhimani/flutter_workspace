import 'dart:io';
void main()
{
  print("enter your marks");
  int marks =int.parse(stdin.readLineSync().toString());
  if(marks>=90)
    {
      print(" A GRADE");
    }
  else if(marks>=80)
  {
    print(" B GRADE");
  }
  else if(marks>=70)
  {
    print(" C GRADE");
  }
  else if(marks>=60)
  {
    print(" D GRADE");
  }
  else
  {
    print(" F GRADE");
  }
}