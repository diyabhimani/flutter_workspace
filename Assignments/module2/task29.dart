void main() {
  List<int> list1 = [5, 3, 1, 2];
  List<int> list2 = [4, 2, 6, 1];
  List<int> list3 = [7, 3, 8];
  List<int> combinedList = [...list1, ...list2, ...list3];
  List<int> uniqueList = combinedList.toSet().toList();
  uniqueList.sort();
  print(uniqueList);
}
