import 'package:dhilwise/Utils/resources/colors.dart';
import 'package:dhilwise/model/goals_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:nb_utils/nb_utils.dart';

class CircleArc extends StatefulWidget {
  const CircleArc({super.key, required this.goals});

  final GoalsModel goals;

  @override
  State<CircleArc> createState() => _CircleArcState();
}

class _CircleArcState extends State<CircleArc> with SingleTickerProviderStateMixin {
  late Animation<double> animation;

  late AnimationController animationController;

  // store progress percentage

  late double progressPercentage;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Calculate progress percentage

    progressPercentage = (widget.goals.currentAmount / widget.goals.targetAmount) * 100;

    // Ensure progress doesn't exceed 100%

    progressPercentage = progressPercentage.clamp(0.0, 100);

    final curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeInOutCubic);

    animation = Tween<double>(begin: 0.0, end: (progressPercentage / 100) * (2 * math.pi)).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: const Size(300, 300),
          painter: ProgressArc(5.4, AppColors.whiteColorDim, true),
        ),
        CustomPaint(
          size: const Size(300, 300),
          // Convert to percentage radius
          painter: ProgressArc(animation.value, AppColors.whiteColor, false),
        ),
        Positioned(
          top: 80,
          left: 115,
          child: Column(
            children: [
              const Icon(
                Icons.home,
                size: 90,
                color: AppColors.whiteColor,
              ),
              Text(
                '\$${widget.goals.currentAmount}',
                style: boldTextStyle(size: 20, color: AppColors.whiteColor),
              ),
              Text(
                'You Saved',
                style: secondaryTextStyle(color: AppColors.whiteColorDim),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ProgressArc extends CustomPainter {
  double? arc;

  Color progressColor;

  bool isBackground;

  ProgressArc(this.arc, this.progressColor, this.isBackground);

  @override
  void paint(Canvas canvas, Size size) {
    const rect = Rect.fromLTRB(50, 50, 270, 270);

    const startAngle = 90.0;

    final sweepAngle = arc ?? math.pi;

    const userCenter = false;

    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    if (isBackground) {}

    canvas.drawArc(rect, startAngle, sweepAngle, userCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
