import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/app_consts.dart';
import 'package:kan_bagisi/models/contact.dart';
import 'package:kan_bagisi/providers/contact_provider.dart';
import 'package:kan_bagisi/utils/shortcuts.dart';

class ContactController extends GetxController {
  final ContactProvider _contactProvider = Get.put(ContactProvider());
  final formKey = GlobalKey<FormBuilderState>();
  Rx<Contact> contact = Rx<Contact>(Contact());

  void saveContact() async {
    try {
      contact.value.userID = Get.userId;
      await _contactProvider.save(contact.value);
      contact.value = Contact();
      formKey.currentState.reset();
      Get.showSnackbar(WidgetConsts.successBar("Result",
          "The message is reached to us, we'll contact with you If needed"));
    } catch (e) {
      print("Heldi 3");
      Get.showSnackbar(WidgetConsts.errorBar("Result", e.toString()));
    }
  }
}
