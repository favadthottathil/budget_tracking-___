class ContributionModel {
  final int amount;

  final String date;

  final String goalId;

 

  ContributionModel({
    required this.amount,
    required this.date,
    required this.goalId,
    
  });

  factory ContributionModel.fromJson(Map<String, dynamic> map) {
    return ContributionModel(
      amount: map['amount'],
      date: map['date'],
      goalId: map['goalId'],
      
    );
  }
}
