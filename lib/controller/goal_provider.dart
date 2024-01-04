import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhilwise/model/goals_model.dart';
import 'package:flutter/material.dart';

class GoalProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<GoalsModel> getGoalDetailsStream(String uid) {
    return _firestore.collection('goals').doc(uid).snapshots().map((
          snapshot,
        ) => GoalsModel.fromJson(snapshot.data() as Map<String, dynamic> )
            );
  }
}
