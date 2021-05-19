import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kan_bagisi/components/app_button.dart';
import 'package:kan_bagisi/controllers/profile_controller.dart';
import 'package:kan_bagisi/utils/shortcuts.dart';

import '../app_consts.dart';

class ProfileFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () {
            if (!Get.auth.profile.value.isValid()) {
              Get.showSnackbar(WidgetConsts.errorBar(
                  "Result", "You need to create a profile to exit form"));
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("Profile Form"),
            ),
            body: SingleChildScrollView(
              child: FormBuilder(
                key: controller.formKey,
                enabled: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      FormBuilderTextField(
                        initialValue: controller.profile?.name,
                        style: WidgetConsts.inputStyle,
                        name: 'name',
                        onSaved: (String value) {
                          controller.profile.name = value;
                        },
                        decoration: InputDecoration(labelText: "Name"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      WidgetConsts.uiSpacer(vertical: 25),
                      FormBuilderTextField(
                        initialValue: controller.profile?.surname,
                        style: WidgetConsts.inputStyle,
                        name: 'surname',
                        onSaved: (String value) {
                          controller.profile.surname = value;
                        },
                        decoration: InputDecoration(labelText: "Surname"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      WidgetConsts.uiSpacer(vertical: 25),
                      FormBuilderTextField(
                        initialValue: controller.profile?.phone,
                        style: WidgetConsts.inputStyle,
                        name: 'phone',
                        onSaved: (String value) {
                          controller.profile.phone = value;
                        },
                        decoration: InputDecoration(labelText: "Phone"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.numeric(context)
                        ]),
                      ),
                      WidgetConsts.uiSpacer(vertical: 25),
                      FormBuilderDropdown<String>(
                        initialValue: controller.profile?.bloodGroup,
                        style: WidgetConsts.inputStyle,
                        name: 'bloodgroup',
                        allowClear: true,
                        items: WidgetConsts.bloodGroupMenuItems,
                        onSaved: (String value) {
                          controller.profile.bloodGroup = value;
                        },
                        decoration: InputDecoration(labelText: "Blood Group"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      WidgetConsts.uiSpacer(vertical: 25),
                      FormBuilderTextField(
                        initialValue: controller.profile?.address,
                        minLines: 2,
                        maxLines: 5,
                        style: WidgetConsts.inputStyle,
                        name: 'address',
                        onSaved: (String value) {
                          controller.profile.address = value;
                        },
                        decoration: InputDecoration(labelText: "Address"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      WidgetConsts.uiSpacer(vertical: 25),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppButton(
                          onPressed: () {
                            if (controller.formKey.currentState
                                .saveAndValidate()) {
                              controller.upsertProfile();
                            }
                          },
                          icon: Icon(
                            Icons.save,
                            size: 24,
                            color: Colors.white,
                          ),
                          text: Text(
                            "Save",
                            style: Get.textTheme.subtitle1
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
