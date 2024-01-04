
import 'package:dhilwise/Utils/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller, this.autovalidateMode, this.validator,
  });

  final String hint;

  final TextEditingController controller;

  final AutovalidateMode? autovalidateMode;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: AppColors.whiteColorDim,
      child: SizedBox(
        height: 60,
        child: Center(
          child: TextFormField(
            controller: controller,
            autofocus: false,
            validator: validator,
            autovalidateMode: autovalidateMode,
            decoration: InputDecoration(
              hintText: hint,
              fillColor: AppColors.whiteColor,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
