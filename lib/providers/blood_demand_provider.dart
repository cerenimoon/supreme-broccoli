import 'package:kan_bagisi/models/blood_demand.dart';
import 'package:kan_bagisi/providers/provider.dart';

class BloodDemandProvider extends Provider<BloodDemand> {
  BloodDemandProvider()
      : super(fromMap: BloodDemand.fromMap, path: "blood_demand");
}
