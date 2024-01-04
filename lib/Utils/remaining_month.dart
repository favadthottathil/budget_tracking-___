int calculateRemainingMonths({required String dateString}) {
  List<String> dateParts = dateString.split('-');

  List<int> dateComponents = dateParts.map((part) => int.parse(part)).toList();

  int year = dateComponents[0];

  int month = dateComponents[1];

  int day = dateComponents[2];

  DateTime endDate = DateTime(year, month, day);

  DateTime currentDate = DateTime.now();

  return (endDate.year - currentDate.year) * 12 + endDate.month - currentDate.month;
}
