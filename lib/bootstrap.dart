import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:scheck/injection.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();


  // Initialize Supabase first
  await Supabase.initialize(
    url: 'https://gsyadwijnbcrtbavxjpm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdzeWFkd2lqbmJjcnRiYXZ4anBtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE1MzY4OTIsImV4cCI6MjA4NzExMjg5Mn0.A-vOcIKZik58bA4tXlO3wYmtPFy0lCl1YGgG2XpSCJU',
  );

  // Add cross-flavor configuration here
  configureDependencies();

  runApp(await builder());
}
