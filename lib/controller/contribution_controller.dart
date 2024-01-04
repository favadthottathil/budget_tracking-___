import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhilwise/model/contribution_model.dart';

class ContributionController {
 Future<List<ContributionModel>> getContributionDetails({required String goalId}) async {
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection(
          'contributions',
        )
        .where(
          'goalId',
          isEqualTo: goalId,
        )
        .get();

   return data.docs.map((snapshot) => ContributionModel.fromJson(snapshot.data())).toList();
  }
}
