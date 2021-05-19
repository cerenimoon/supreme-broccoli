import 'package:kan_bagisi/models/example.dart';
import 'package:kan_bagisi/providers/provider.dart';

class ExampleProvider extends Provider<Example> {
  ExampleProvider() : super(fromMap: Example.fromMap, path: "example");
}
