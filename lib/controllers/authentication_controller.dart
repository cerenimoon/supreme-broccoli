//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/app_consts.dart';
import 'package:kan_bagisi/models/profile.dart';
import 'package:kan_bagisi/providers/profile_provider.dart';
import 'package:kan_bagisi/utils/firebase_messaging_helper.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<Profile> profile = Rx<Profile>(Profile());
  final ProfileProvider _profileProvider = Get.put(ProfileProvider());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setProfile() async {
    try {
      if (isAuthenticated) {
        profile.value =
            (await _profileProvider.getListBy("userID", isEqualTo: user.uid))
                .first;

        if (profile.value.isValid()) {
          profile.value.tokenID = await FirebaseMessagingHelper.getToken;
          profile.value = await _profileProvider.update(profile.value);
        }
      }
    } catch (e) {
      print("Profile");
      print(e);
    }
  }

  User get user {
    return _auth.currentUser;
  }

  bool get isAuthenticated {
    return user != null;
  }

  Future<String> signIn(LoginData loginData) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: loginData.name, password: loginData.password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Unexpected error occurred";
    }
  }

  Future<String> createUser(LoginData loginData) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: loginData.name, password: loginData.password);

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Unexpected error occurred";
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Unexpected error occurred";
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(AppRoutes.SPLASH);
      return null;
    } catch (e) {
      Get.snackbar("Error", "Unexpected error occurred");
    }
  }
}
