import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/app_consts.dart';
import 'package:kan_bagisi/components/app_button.dart';
import 'package:kan_bagisi/controllers/example_controller.dart';

class ExampleFormView extends StatelessWidget {
  final ExampleController controller = Get.put(ExampleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example Form"),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.always,
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
                  style: WidgetConsts.inputStyle,
                  name: 'field1',
                  onSaved: (String value) {
                    controller.example.field1 = value;
                  },
                  decoration: InputDecoration(labelText: "Field 1 (String)"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                ),
                WidgetConsts.uiSpacer(vertical: 25),
                FormBuilderTextField(
                  style: WidgetConsts.inputStyle,
                  name: 'field2',
                  keyboardType: TextInputType.number,
                  onSaved: (String value) {
                    controller.example.field2 = num.tryParse(value);
                  },
                  decoration: InputDecoration(labelText: "Field 2 (int)"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.numeric(context),
                    FormBuilderValidators.max(context, 70),
                  ]),
                ),
                WidgetConsts.uiSpacer(vertical: 25),
                FormBuilderDateTimePicker(
                  name: 'field3',
                  // onChanged: _onChanged,
                  inputType: InputType.date,
                  decoration: InputDecoration(
                    labelText: 'Field 3 DateTime',
                  ),
                  onSaved: (DateTime value) {
                    controller.example.field3 = value;
                  },
                  initialTime: TimeOfDay(hour: 8, minute: 0),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  // initialValue: DateTime.now(),
                  // enabled: true,
                ),
                WidgetConsts.uiSpacer(vertical: 25),
                FormBuilderDropdown(
                  name: 'field4',
                  decoration: InputDecoration(
                    labelText: 'Field 4 - DownDown',
                  ),
                  // initialValue: 'Male',
                  allowClear: true,
                  onSaved: (String value) {
                    controller.example.field4 = value;
                  },
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                  items: ["Male", "Female"]
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text('$gender'),
                          ))
                      .toList(),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppButton(
                    onPressed: () {
                      if (controller.formKey.currentState.saveAndValidate()) {
                        controller.saveExample();
                      }
                    },
                    icon: Icon(
                      Icons.save,
                      size: 24,
                      color: Colors.white,
                    ),
                    text: Text(
                      "Save",
                      style: Get.theme.textTheme.subtitle1
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    "Example Count = ${controller.exampleCount}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
