import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/features/navigation/presentation/pages/navigation_page.dart';
import 'package:scheck/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:scheck/injection.dart';
import 'package:scheck/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SettingsBloc>()..add(const SettingsEvent.load()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: state.settings != null ? Color(state.settings!.primaryColor) : Colors.indigo,
              ),
              useMaterial3: true,
            ),
            locale: state.settings != null ? Locale(state.settings!.locale) : const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const NavigationPage(),
          );
        },
      ),
    );
  }
}
