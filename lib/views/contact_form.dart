import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kan_bagisi/components/app_button.dart';
import 'package:kan_bagisi/controllers/contact_controller.dart';

import '../app_consts.dart';

class ContactFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(
        init: ContactController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Contact"),
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
                        style: WidgetConsts.inputStyle,
                        name: 'email',
                        onSaved: (String value) {
                          controller.contact.value.email = value;
                        },
                        decoration: InputDecoration(labelText: "Email"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.email(context)
                        ]),
                      ),
                      WidgetConsts.uiSpacer(vertical: 25),
                      FormBuilderTextField(
                        style: WidgetConsts.inputStyle,
                        name: 'message',
                        maxLines: 6,
                        minLines: 3,
                        keyboardType: TextInputType.number,
                        onSaved: (String value) {
                          controller.contact.value.message = value;
                        },
                        decoration: InputDecoration(labelText: "Message"),
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
                              controller.saveContact();
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
          );
        });
  }
}
