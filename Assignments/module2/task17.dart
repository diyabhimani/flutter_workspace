void main()
{
  Book b = Book("Harry Potter", "J.K. Rowling", 2005);

  b.showDetails();
  print(b.isOld());
}

class Book
{
  String title;
  String author;
  int year;
  Book(this.title, this.author, this.year);
  void showDetails()
  {
    print(title);
    print(author);
    print(year);
  }

  bool isOld()
  {
    return (DateTime.now().year - year) > 10;
  }
}
