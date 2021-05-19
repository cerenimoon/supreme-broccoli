import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/models/blood_demand.dart';

class BloodDemandInfo extends StatelessWidget {
  final BloodDemand bloodDemand;

  const BloodDemandInfo({Key key, this.bloodDemand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {0: FlexColumnWidth(1.6), 1: FlexColumnWidth(2.0)},
      children: [
        _createTableRow("Fullname: ", bloodDemand.patientFullname),
        _createTableRow("Blood Group: ", bloodDemand.patientBloodGroup),
        _createTableRow("Phone: ", bloodDemand.patientPhone),
        _createTableRow("Address: ", bloodDemand.patientAddress),
      ],
    );
  }

  TableRow _createTableRow(String column, String value) {
    return TableRow(children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            column,
            style: Get.textTheme.subtitle1
                .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(value,
              style: Get.textTheme.subtitle1
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
      ),
    ]);
  }
}
