import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scheck/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:scheck/l10n/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pageNavigationSettings),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.settings == null) {
            return Center(child: Text(l10n.errorFailedToLoadSettings));
          }

          final settings = state.settings!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Language Selector
                  Text(l10n.titleLanguage, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: settings.locale,
                    items: [
                      DropdownMenuItem(value: 'en', child: Text(l10n.languageEnglish)),
                      DropdownMenuItem(value: 'es', child: Text(l10n.languageSpanish)),
                    ],
                    onChanged: (locale) {
                      if (locale != null) {
                        context.read<SettingsBloc>().add(SettingsEvent.changeLanguage(locale));
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Primary Color Selector
                  Text(l10n.titlePrimaryColor, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [Colors.indigo, Colors.deepPurple, Colors.teal, Colors.amber, Colors.blueAccent, Colors.blueGrey, Colors.green, Colors.lime].map((color) {
                      return GestureDetector(
                        onTap: () {
                          context.read<SettingsBloc>().add(SettingsEvent.changePrimaryColor(color.value));
                        },
                        child: CircleAvatar(
                          backgroundColor: color,
                          child: settings.primaryColor == color.value
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
