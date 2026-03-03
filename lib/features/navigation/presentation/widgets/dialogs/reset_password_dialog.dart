import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/stylers/shape_styler.dart';
import 'package:scheck/core/utils/dialog_handler.dart';
import 'package:scheck/core/utils/error_handler.dart';
import 'package:scheck/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scheck/l10n/l10n.dart';

class ResetPasswordDialog extends StatefulWidget {
  const ResetPasswordDialog({super.key});

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  late TextEditingController _emailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final currentUser = context.read<AuthBloc>().state.maybeWhen(
      authenticated: (user) => user,
      orElse: () => null,
    );
    _emailController = TextEditingController(text: currentUser?.email ?? '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          passwordResetSent: () {
            setState(() => _isLoading = false);
            Navigator.of(context).pop();
            DialogHandler.showSnackBar(context, message: l10n.resetPasswordMessage);
          },
          error: (message) {
            setState(() => _isLoading = false);
            ErrorHandler.showAtSnackBar(context, message);
          },
        );
      },
      child: AlertDialog(
        shape: ShapeStyler.DialogShape.outlinedBorder,
        title: Text(l10n.menuResetPassword),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.forgotPassword),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: l10n.email,
                border: ShapeStyler.InputShape.inputBorder,
              ),
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : _submit,
            child: _isLoading 
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.confirm),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_emailController.text.trim().isNotEmpty) {
      setState(() => _isLoading = true);
      context.read<AuthBloc>().add(
        AuthEvent.resetPasswordRequested(_emailController.text.trim()),
      );
    }
  }
}
