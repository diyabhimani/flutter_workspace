class Product
{
  String name;
  double price;
  Product(this.name, this.price);
}

class Cart
{
  List<Product> products = [];
  void addProduct(Product product)
  {
    products.add(product);
    print('${product.name} added to cart');
  }

  double calculateTotal()
  {
    double total = 0;
    for (var product in products) {
      total += product.price;
    }
    return total;
  }
}

class Order
{
  Cart cart;
  Order(this.cart);
  void showOrderDetails()
  {
    print('\nOrder Details:');
    for (var product in cart.products)
    {
      print('- ${product.name} : ₹${product.price}');
    }
    print('Total Amount: ₹${cart.calculateTotal()}');
  }
}

void main()
{
  Product p1 = Product('Laptop', 55000);
  Product p2 = Product('Mouse', 500);
  Product p3 = Product('Keyboard', 1200);
  Cart cart = Cart();
  cart.addProduct(p1);
  cart.addProduct(p2);
  cart.addProduct(p3);
  Order order = Order(cart);
  order.showOrderDetails();
}
