import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart'; // Ten plik wygeneruje się sam!

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();