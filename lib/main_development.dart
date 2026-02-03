import 'package:scheck/app/app.dart';
import 'package:scheck/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
