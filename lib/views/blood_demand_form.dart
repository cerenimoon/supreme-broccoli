import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kan_bagisi/components/app_button.dart';
import 'package:kan_bagisi/controllers/blood_demand_form_controller.dart';

import '../app_consts.dart';

class BloodDemandFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BloodDemandFormController>(
      init: BloodDemandFormController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Blood Demand Form"),
          ),
          body: SingleChildScrollView(
            child: FormBuilder(
              key: controller.formKey,
              enabled: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    FormBuilderTextField(
                      key: Key(
                          controller.bloodDemand.value?.patientName ?? 'name'),
                      initialValue: controller.bloodDemand.value?.patientName,
                      style: WidgetConsts.inputStyle,
                      name: 'name',
                      onSaved: (String value) {
                        controller.bloodDemand.value.patientName = value;
                      },
                      decoration: InputDecoration(labelText: "Patient Name"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    WidgetConsts.uiSpacer(vertical: 25),
                    FormBuilderTextField(
                      key: Key(controller.bloodDemand.value?.patientSurname ??
                          'surname'),
                      initialValue:
                          controller.bloodDemand.value?.patientSurname,
                      style: WidgetConsts.inputStyle,
                      name: 'surname',
                      onSaved: (String value) {
                        controller.bloodDemand.value.patientSurname = value;
                      },
                      decoration: InputDecoration(labelText: "Patient Surname"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    WidgetConsts.uiSpacer(vertical: 25),
                    FormBuilderTextField(
                      key: Key(controller.bloodDemand.value?.patientPhone ??
                          'phone'),
                      initialValue: controller.bloodDemand.value?.patientPhone,
                      style: WidgetConsts.inputStyle,
                      name: 'phone',
                      onSaved: (String value) {
                        controller.bloodDemand.value.patientPhone = value;
                      },
                      decoration: InputDecoration(labelText: "Patient Phone"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context)
                      ]),
                    ),
                    WidgetConsts.uiSpacer(vertical: 25),
                    FormBuilderDropdown<String>(
                      key: Key(
                          controller.bloodDemand.value?.patientBloodGroup ??
                              'bloodgroup'),
                      initialValue:
                          controller.bloodDemand.value?.patientBloodGroup,
                      style: WidgetConsts.inputStyle,
                      name: 'bloodgroup',
                      allowClear: true,
                      items: WidgetConsts.bloodGroupMenuItems,
                      onSaved: (String value) {
                        controller.bloodDemand.value.patientBloodGroup = value;
                      },
                      decoration:
                          InputDecoration(labelText: "Patient Blood Group"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    WidgetConsts.uiSpacer(vertical: 25),
                    FormBuilderTextField(
                      key: Key(controller.bloodDemand.value?.patientAddress ??
                          'address'),
                      initialValue:
                          controller.bloodDemand.value?.patientAddress,
                      minLines: 2,
                      maxLines: 5,
                      style: WidgetConsts.inputStyle,
                      name: 'address',
                      onSaved: (String value) {
                        controller.bloodDemand.value.patientAddress = value;
                      },
                      decoration: InputDecoration(labelText: "Patient Address"),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(context),
                        ],
                      ),
                    ),
                    WidgetConsts.uiSpacer(vertical: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButton(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.red[500],
                              Colors.red[400],
                              Colors.red[700],
                            ],
                          ),
                          onPressed: () {
                            controller.fillFormByProfile();
                          },
                          icon: Icon(
                            Icons.person,
                            size: 24,
                            color: Colors.white,
                          ),
                          text: Text(
                            "Use My Info",
                            style: Get.textTheme.subtitle1
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        AppButton(
                          onPressed: () {
                            if (controller.formKey.currentState
                                .saveAndValidate()) {
                              controller.upsertBloodDemand();
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
