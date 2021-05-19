import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/app_consts.dart';
import 'package:kan_bagisi/controllers/authentication_controller.dart';
import 'package:kan_bagisi/utils/firebase_messaging_helper.dart';
import 'package:kan_bagisi/utils/notification_helper.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AuthenticationController _authenticationController =
      Get.find<AuthenticationController>();

  double _heigth = 1;
  double _weight = 1;
  @override
  void initState() {
    NotificationHelper.init();
    FirebaseMessagingHelper.init();
    runAnimations();
    navigateTo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SafeArea(
                child: AnimatedContainer(
                  width: _heigth,
                  height: _weight,
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.elasticOut,
                  child: Image.asset(
                    'assets/images/app_icon.png',
                    fit: BoxFit.fitWidth,
                    width: _heigth,
                    height: _weight,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void navigateTo() async {
    await Future.delayed(Duration(milliseconds: 1500));
    if (_authenticationController.isAuthenticated) {
      await _authenticationController.setProfile();
      Get.offNamed(AppRoutes.HOME);
    } else {
      Get.offNamed(AppRoutes.LOGIN);
    }
  }

  void runAnimations() async {
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      _heigth = 169;
      _weight = 169;
    });
  }
}
