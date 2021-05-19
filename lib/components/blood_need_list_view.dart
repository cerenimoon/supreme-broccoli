import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/models/blood_demand.dart';
import 'package:kan_bagisi/utils/app_icons.dart';

import '../app_consts.dart';

class BloodDemandListView extends StatelessWidget {
  final List<BloodDemand> bloodDemandList;
  final Function(BloodDemand) onSeledted;

  const BloodDemandListView({Key key, this.bloodDemandList, this.onSeledted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => Divider(),
      itemCount: bloodDemandList.length,
      itemBuilder: (_, index) {
        BloodDemand bloodDemand = bloodDemandList[index];
        return ListTile(
          onTap: () => this.onSeledted(bloodDemand),
          visualDensity:
              VisualDensity(horizontal: VisualDensity.minimumDensity),
          leading: Icon(AppIcons.water_drop,
              size: 35, color: Get.theme.primaryColor),
          subtitle: Row(
            children: [
              Chip(
                backgroundColor: Get.theme.accentColor.withOpacity(.5),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                label: Text(
                  bloodDemand.patientBloodGroup,
                  style: Get.textTheme.bodyText2,
                ),
              ),
              WidgetConsts.uiSpacer(horizontal: 10.0),
              Chip(
                backgroundColor: Get.theme.accentColor.withOpacity(.5),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                label: Text(
                  bloodDemand.patientPhone,
                  style: Get.textTheme.bodyText2,
                ),
              ),
            ],
          ),
          title: Text(
            bloodDemand.patientFullname,
            style: Get.textTheme.subtitle1.copyWith(fontSize: 18),
          ),
        );
      },
    );
  }
}
