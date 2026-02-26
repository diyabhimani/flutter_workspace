void main()
{
  Car car = Car();
  Bike bike = Bike();
  car.showDetails();
  bike.showDetails();
}
class Vehicle
{
  String type = "Vehicle";
  void showDetails()
  {
    print("This is a vehicle");
  }
}
class Car extends Vehicle
{
  @override
  void showDetails() {
    print("Type: Car");
    print("Fuel Type: Petrol");
    print("Max Speed: 180 km/h");
  }
}

// Subclass Bike
class Bike extends Vehicle {
  @override
  void showDetails() {
    print("Type: Bike");
    print("Fuel Type: Petrol");
    print("Max Speed: 120 km/h");
  }
}
