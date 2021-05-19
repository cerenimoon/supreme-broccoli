import 'package:kan_bagisi/models/profile.dart';
import 'package:kan_bagisi/providers/provider.dart';

class ProfileProvider extends Provider<Profile> {
  ProfileProvider() : super(fromMap: Profile.fromMap, path: "profile");
}
