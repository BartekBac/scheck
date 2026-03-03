import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/stylers/shape_styler.dart';
import 'package:scheck/core/utils/error_handler.dart';
import 'package:scheck/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scheck/l10n/l10n.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          unauthenticated: () {
            Navigator.of(context).pop();
          },
          error: (message) {
            Navigator.of(context).pop();
            ErrorHandler.showAtSnackBar(context, message);
          },
        );
      },
      child: AlertDialog(
        shape: ShapeStyler.DialogShape.outlinedBorder,
        title: Text(l10n.menuLogOut),
        content: Text(l10n.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.whenOrNull(
                unauthenticated: () {
                  Navigator.of(context).popAndPushNamed('/sign_in');
                },
              );
            },
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signOutRequested());
              },
              child: Text(l10n.menuLogOut),
            ),
          ),
        ],
      ),
    );
  }
}
