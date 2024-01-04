List<int> getDateComponents({required String dateString}) {
  List<String> dateParts = dateString.split('-');

  return dateParts.map((part) => int.parse(part)).toList();
}
