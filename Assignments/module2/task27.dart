void main() async
{
  print("Fetching users...");

  List<String> users = await fetchUsers();

  print("All users loaded:");
  for (var user in users)
  {
    print(user);
  }
}
Future<List<String>> fetchUsers() async
{
  List<String> users = [];

  users.add(await fetchUser("User 1"));
  users.add(await fetchUser("User 2"));
  users.add(await fetchUser("User 3"));

  return users;
}
Future<String> fetchUser(String name) async
{
  await Future.delayed(Duration(seconds: 1));
  return name;
}
