import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/app_consts.dart';
import 'package:kan_bagisi/controllers/authentication_controller.dart';
import 'package:kan_bagisi/models/example.dart';
import 'package:kan_bagisi/providers/example_provider.dart';

class ExampleController extends GetxController {
  var exampleCount = 0.obs;
  final ExampleProvider _exampleProvider = Get.put(ExampleProvider());
  final formKey = GlobalKey<FormBuilderState>();
  var example = Example();
  final AuthenticationController _authenticationController =
      Get.find<AuthenticationController>();

  @override
  void onInit() async {
    exampleCount.value = await _exampleProvider.countAll;
    print(exampleCount.value);
    super.onInit();
  }

  void saveExample() async {
    try {
      example.userID = _authenticationController.user.uid;
      String id = await _exampleProvider.save(example);
      example.documentID = id;
      Get.showSnackbar(
          WidgetConsts.successBar("result", "The example added to db"));
      exampleCount.value++;
    } catch (e) {
      Get.showSnackbar(WidgetConsts.successBar("result", e.toString()));
    }
  }
}
