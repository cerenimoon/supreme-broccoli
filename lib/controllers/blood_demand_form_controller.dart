import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/app_consts.dart';
import 'package:kan_bagisi/models/blood_demand.dart';
import 'package:kan_bagisi/models/profile.dart';
import 'package:kan_bagisi/providers/blood_demand_provider.dart';
import 'package:kan_bagisi/providers/profile_provider.dart';
import 'package:kan_bagisi/utils/firebase_messaging_helper.dart';
import 'package:kan_bagisi/utils/shortcuts.dart';

class BloodDemandFormController extends GetxController {
  final BloodDemandProvider _bloodDemandProvider =
      Get.put(BloodDemandProvider());
  final formKey = GlobalKey<FormBuilderState>();
  Rx<BloodDemand> bloodDemand = Rx<BloodDemand>(Get.arguments ?? BloodDemand());
  ProfileProvider _profileProvider = Get.put(ProfileProvider());

  void upsertBloodDemand() async {
    try {
      if (bloodDemand.value.documentID == null) {
        bloodDemand.value.userID = Get.userId;
        bloodDemand.value.documentID =
            await _bloodDemandProvider.save(bloodDemand.value);

        List<Profile> profiles = await _profileProvider.getListBy("userID",
            isNotEqualTo: Get.userId);

        profiles.forEach((profile) {
          if (profile.tokenID != null) {
            FirebaseMessagingHelper.sendNotification(
                profile.tokenID,
                bloodDemand.value.patientFullname +
                    ", " +
                    bloodDemand.value.patientPhone +
                    ", " +
                    bloodDemand.value.patientAddress,
                "There is someone who needs blood! ${bloodDemand.value.patientBloodGroup}");
          }
        });
      } else {
        bloodDemand.value =
            await _bloodDemandProvider.update(bloodDemand.value);
      }
      Get.showSnackbar(
          WidgetConsts.successBar("Result", "Blood Demand succesfully saved"));
    } catch (e) {
      Get.showSnackbar(WidgetConsts.errorBar("Result", e.toString()));
    }
  }

  void fillFormByProfile() {
    bloodDemand.value.patientName = Get.auth.profile.value.name;
    bloodDemand.value.patientSurname = Get.auth.profile.value.surname;
    bloodDemand.value.patientPhone = Get.auth.profile.value.phone;
    bloodDemand.value.patientBloodGroup = Get.auth.profile.value.bloodGroup;
    bloodDemand.value.patientAddress = Get.auth.profile.value.address;
    bloodDemand.refresh();
    this.refresh();
  }
}
