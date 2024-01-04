class GoalsModel {
  final String title;

  final int targetAmount;

  final int currentAmount;

  final String expectedCompletionDate;

  GoalsModel({
    required this.title,
    required this.targetAmount,
    required this.currentAmount,
    required this.expectedCompletionDate,
  });

  factory GoalsModel.fromJson(Map<String, dynamic> map) {
    return GoalsModel(
      title: map['title'],
      targetAmount: map['targetAmount'],
      currentAmount: map['currentAmount'],
      expectedCompletionDate: map['expectedCompletionDate'],
    );
  }
}
