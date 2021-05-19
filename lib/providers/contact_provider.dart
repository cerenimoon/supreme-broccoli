import 'package:kan_bagisi/models/contact.dart';
import 'package:kan_bagisi/providers/provider.dart';

class ContactProvider extends Provider<Contact> {
  ContactProvider() : super(fromMap: Contact.fromMap, path: "contact");
}
