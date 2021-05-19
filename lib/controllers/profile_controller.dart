import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/app_consts.dart';
import 'package:kan_bagisi/models/profile.dart';
import 'package:kan_bagisi/providers/profile_provider.dart';
import 'package:kan_bagisi/utils/shortcuts.dart';

class ProfileController extends GetxController {
  final ProfileProvider _profileProvider = Get.put(ProfileProvider());
  final formKey = GlobalKey<FormBuilderState>();
  Profile profile = Get.auth.profile.value.clone();

  void upsertProfile() async {
    try {
      if (profile.documentID == null) {
        profile.userID = Get.userId;
        profile.documentID = await _profileProvider.save(profile);
      } else {
        profile = await _profileProvider.update(profile);
      }
      Get.auth.profile.value = profile;
      Get.showSnackbar(
          WidgetConsts.successBar("Result", "Profile succesfully saved"));
    } catch (e) {
      Get.showSnackbar(WidgetConsts.errorBar("Result", e.toString()));
    }
  }
}
