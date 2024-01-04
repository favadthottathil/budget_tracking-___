import 'package:dhilwise/Utils/remaining_month.dart';
import 'package:dhilwise/Utils/resources/colors.dart';
import 'package:dhilwise/components/circle_arc.dart';
import 'package:dhilwise/controller/auth_controller.dart';
import 'package:dhilwise/controller/contribution_controller.dart';
import 'package:dhilwise/controller/goal_provider.dart';
import 'package:dhilwise/model/contribution_model.dart';
import 'package:dhilwise/model/goals_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final GoalProvider _controller = GoalProvider();

  final ContributionController contributionController = ContributionController();

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: SafeArea(
        child: StreamBuilder<GoalsModel>(
            stream: _controller.getGoalDetailsStream('2Q0e21Ologyt7aVhowh9'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text('No Data Available');
              }

              final GoalsModel goal = snapshot.data!;

              final num remainingAmount = goal.targetAmount - goal.currentAmount;

              final remaintinDate = calculateRemainingMonths(dateString: goal.expectedCompletionDate);

              int additionalMonthlySavigs = remainingAmount ~/ remaintinDate;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            authController.logOut();
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        goal.title,
                        style: boldTextStyle(size: 30, color: AppColors.whiteColor),
                      ),
                    ),
                    CircleArc(goals: goal),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Goal',
                              style: boldTextStyle(color: AppColors.whiteColor, size: 20),
                            ),
                            Text(
                              'by ${goal.expectedCompletionDate}',
                              style: boldTextStyle(size: 15, color: AppColors.whiteColorDim),
                            )
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '\$${goal.targetAmount.toString()}',
                          style: boldTextStyle(color: AppColors.whiteColor, size: 20),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 65),
                    20.height,
                    Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent.shade400,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Need more savings',
                                style: boldTextStyle(color: AppColors.whiteColor),
                              ),
                              const Spacer(),
                              Text(
                                '\$${remainingAmount.toStringAsFixed(2)}',
                                style: boldTextStyle(color: AppColors.whiteColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Monthly Saving Projection',
                                style: boldTextStyle(color: AppColors.whiteColor),
                              ),
                              const Spacer(),
                              Text(
                                '\$$additionalMonthlySavigs',
                                style: boldTextStyle(color: AppColors.whiteColor),
                              ),
                            ],
                          )
                        ],
                      ).paddingAll(10),
                    ).paddingSymmetric(horizontal: 50),
                    20.height,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Contribution History',
                        style: boldTextStyle(
                          size: 20,
                          color: AppColors.whiteColor,
                        ),
                      ).paddingOnly(left: 50),
                    ),
                    40.height,
                    Container(
                      // height: double.infinity,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 45),
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: FutureBuilder<List<ContributionModel>>(
                          future: contributionController.getContributionDetails(goalId: '2Q0e21Ologyt7aVhowh9'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              log(snapshot.error.toString());
                              return Center(child: Text(snapshot.error.toString()));
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              log('No data');
                              return const Text('No Data Available');
                            }

                            final contributionList = snapshot.data!;

                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: contributionList.length,
                                itemBuilder: (context, index) {
                                  final ContributionModel contribution = contributionList[index];
                                  return ListTile(
                                    title: Text(
                                      'Amount : \$${contribution.amount}',
                                      style: boldTextStyle(color: AppColors.blackColor),
                                    ),
                                    subtitle: Text(
                                      'Date : ${contribution.date}',
                                      style: boldTextStyle(color: AppColors.blackColor),
                                    ),
                                  ).paddingSymmetric(horizontal: 50);
                                });
                          }),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
