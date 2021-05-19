import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/controllers/authentication_controller.dart';

extension ShortCuts on GetInterface {
  AuthenticationController get auth => find<AuthenticationController>();
  User get user => auth.user;
  String get userId => user.uid;
}
