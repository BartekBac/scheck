import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/extensions/list_extension.dart';
import 'package:scheck/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scheck/l10n/l10n.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState.maybeMap(
          authenticated: (state) => state.user,
          orElse: () => null,
        );
        final title = user != null
            ? '${[l10n.greet1, l10n.greet2, l10n.greet3].randomElement()}, ${user.displayName}!'
            : l10n.appTitle;
        return Text(title);
      },
    );
  }
}