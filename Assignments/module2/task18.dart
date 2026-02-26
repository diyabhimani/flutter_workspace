void main()
{
  BankAccount acc = BankAccount("123456", "Diya", 5000);

  acc.deposit(2000);
  acc.withdraw(3000);
  acc.withdraw(5000);
  acc.checkBalance();
}

class BankAccount
{
  String accountNumber;
  String accountHolder;
  double balance;

  BankAccount(this.accountNumber, this.accountHolder, this.balance);

  void deposit(double amount)
  {
    balance += amount;
    print("Deposited: $amount");
  }

  void withdraw(double amount)
  {
    if (amount <= balance)
    {
      balance -= amount;
      print("Withdrawn: $amount");
    } else {
      print("Insufficient balance! Withdrawal not allowed.");
    }
  }

  void checkBalance()
  {
    print("Current Balance: $balance");
  }
}
