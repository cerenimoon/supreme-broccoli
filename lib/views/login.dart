import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/app_consts.dart';
import 'package:kan_bagisi/controllers/authentication_controller.dart';

class LoginView extends StatelessWidget {
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FlutterLogin(
        title: 'Blood Donation',
        theme: LoginTheme(
          beforeHeroFontSize: 30,
        ),
        logo: 'assets/images/app_icon.png',
        onLogin: (LoginData loginData) {
          return authenticationController.signIn(loginData);
        },
        onSignup: (LoginData loginData) {
          return authenticationController.createUser(loginData);
        },
        onSubmitAnimationCompleted: () {
          Get.offAllNamed(AppRoutes.SPLASH);
        },
        onRecoverPassword: (String email) {
          return authenticationController.forgotPassword(email);
        },
      ),
    );
  }
}
