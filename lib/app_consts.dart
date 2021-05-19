import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kan_bagisi/views/blood_demand_form.dart';
import 'package:kan_bagisi/views/contact_form.dart';
import 'package:kan_bagisi/views/example_form.dart';
import 'package:kan_bagisi/views/home.dart';
import 'package:kan_bagisi/views/login.dart';
import 'package:kan_bagisi/views/profile_form.dart';
import 'package:kan_bagisi/views/splash.dart';

class AppRoutes {
  static const HOME = "/home";
  static const LOGIN = "/login";
  static const SPLASH = "/splash";
  static const CONTACT_FORM = "/contact_form";
  static const PROFILE_FORM = "/profile_form";
  static const EXAMPLE_FORM = "/example_form";
  static const BLOOD_NEED_FORM = "/blood_need_form";

  static final initialRoute = SPLASH;
  static final Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.HOME: (_) => HomeView(),
    AppRoutes.LOGIN: (_) => LoginView(),
    AppRoutes.SPLASH: (_) => SplashView(),
    AppRoutes.CONTACT_FORM: (_) => ContactFormView(),
    AppRoutes.BLOOD_NEED_FORM: (_) => BloodDemandFormView(),
    AppRoutes.PROFILE_FORM: (_) => ProfileFormView(),
    AppRoutes.EXAMPLE_FORM: (_) => ExampleFormView(),
  };
}

class WidgetConsts {
  static final TextStyle inputStyle = TextStyle(
      fontSize: 20, color: Colors.grey[900], fontWeight: FontWeight.w500);

  static final ThemeData themeData = ThemeData(
    primarySwatch: Colors.red,
    primaryColor: Colors.redAccent,
    accentColor: Colors.orange,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: inputStyle,
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[700],
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      errorStyle: TextStyle(fontSize: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
    ),
    textTheme: GoogleFonts.latoTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static Widget uiSpacer({double vertical = 0, double horizontal = 0}) =>
      SizedBox(
        height: vertical,
        width: horizontal,
      );

  static GetBar successBar(String title, String message) => GetBar(
        title: title,
        message: message,
        backgroundColor: Colors.green,
        icon: Icon(Icons.done, color: Colors.white),
        duration: Duration(milliseconds: 5000),
        animationDuration: Duration(milliseconds: 500),
      );

  static GetBar errorBar(String title, String message) => GetBar(
        title: title,
        message: message,
        backgroundColor: Colors.red,
        icon: Icon(Icons.error, color: Colors.white),
        duration: Duration(milliseconds: 5000),
        animationDuration: Duration(milliseconds: 500),
      );

  static List<DropdownMenuItem<String>> get bloodGroupMenuItems {
    return DataConsts.bloodGroups
        .map(
          (k, v) => MapEntry(
            v,
            DropdownMenuItem<String>(
              child: Text(k),
              value: v,
            ),
          ),
        )
        .values
        .toList();
  }
}

class DataConsts {
  static final Map<String, String> bloodGroups = {
    "A RhD positive (A+)": "A+",
    "A RhD negative (A-)": "A-",
    "B RhD positive (B+)": "B+",
    "B RhD negative (B-)": "B-",
    "O RhD positive (O+)": "O+",
    "O RhD negative (O-)": "O-",
    "AB RhD positive (AB+)": "AB+",
    "AB RhD negative (AB-)": "AB-"
  };
}
