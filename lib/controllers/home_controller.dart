import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kan_bagisi/app_consts.dart';
import 'package:kan_bagisi/models/blood_demand.dart';
import 'package:kan_bagisi/providers/blood_demand_provider.dart';
import 'package:kan_bagisi/utils/shortcuts.dart';

class HomeController extends GetxController {
  final PageController pageViewController =
      new PageController(initialPage: 0, keepPage: true);
  var selectedNeeds = 0.obs;
  FirebaseStorage storage = FirebaseStorage.instance;

  BloodDemandProvider _bloodDemandProvider = Get.put(BloodDemandProvider());
  Rx<List<BloodDemand>> bloodDemands = Rx<List<BloodDemand>>([]);
  Rx<List<BloodDemand>> myBloodDemands = Rx<List<BloodDemand>>([]);

  @override
  void onReady() {
    controlProfile();
    fetchBloodDemands();
    fetchMyBloodDemands();
    super.onReady();
  }

  Future<void> fetchBloodDemands() async {
    bloodDemands.value = await _bloodDemandProvider.getListBy("userID",
        isNotEqualTo: Get.userId);
    this.update();
  }

  Future<void> fetchMyBloodDemands() async {
    myBloodDemands.value =
        await _bloodDemandProvider.getListBy("userID", isEqualTo: Get.userId);
    this.update();
  }

  void doUploadPhoto() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
      maxHeight: 1920,
      maxWidth: 1080,
    );

    String path = "uploads/" + image.path.split("/").last;

    UploadTask task = storage.ref(path).putFile(image);
    task.then((document) async {
      String link = await storage.ref(path).getDownloadURL();
      await Get.auth.user.updateProfile(photoURL: link);
      this.update();
    });
  }

  void controlProfile() async {
    if (!Get.auth.profile.value.isValid()) {
      Get.toNamed(AppRoutes.PROFILE_FORM);
    }
  }

  void selectNeed(int index) {
    selectedNeeds.value = index;

    pageViewController.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.easeIn);
  }
}
