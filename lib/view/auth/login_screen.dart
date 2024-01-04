import 'package:dhilwise/Utils/resources/colors.dart';
import 'package:dhilwise/Utils/resources/style/buttonstyle.dart';
import 'package:dhilwise/Utils/resources/style/textstyle.dart';
import 'package:dhilwise/components/textfield.dart';
import 'package:dhilwise/controller/auth_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signIn(AuthController authController, String email, String pass) async {
    final msg = await authController.signIn(email, pass);

    if (msg == '') {
      authController.setLoading = false;
      return;
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(email)) {
      return 'Enter a valid Email';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();

    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    final size = MediaQuery.of(context).size;

    return StreamBuilder<User?>(
      stream: authController.stream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainScreen();
        }

        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Center(
            child: SizedBox(
              height: size.height * 0.6,
              width: size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  30.height,
                  CustomTextField(
                    hint: 'Email',
                    controller: emailController,
                    validator: validateEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  30.height,
                  CustomTextField(
                    hint: 'Password',
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (pass) => pass != null && pass.length < 6 ? 'Enter min 6 Characters' : null,
                  ),
                  10.height,
                  30.height,
                  ElevatedButton(
                    onPressed: () {
                      signIn(authController, emailController.text.trim(), passwordController.text.trim());
                    },
                    style: AppButtonStyle.buttonStyle1,
                    child: authController.isLoading
                        ? const Center(child: CircularProgressIndicator(color: AppColors.whiteColor, strokeWidth: 2))
                        : const Text(
                            'CONTINUE',
                            style: AppTextStyle.textStyle1,
                          ),
                  ),
                  30.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
