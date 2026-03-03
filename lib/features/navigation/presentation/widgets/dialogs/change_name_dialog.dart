import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/stylers/shape_styler.dart';
import 'package:scheck/core/utils/dialog_handler.dart';
import 'package:scheck/core/utils/error_handler.dart';
import 'package:scheck/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scheck/l10n/l10n.dart';

class ChangeNameDialog extends StatefulWidget {
  const ChangeNameDialog({super.key});

  @override
  State<ChangeNameDialog> createState() => _ChangeNameDialogState();
}

class _ChangeNameDialogState extends State<ChangeNameDialog> {
  late TextEditingController _nameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final currentUser = context.read<AuthBloc>().state.maybeWhen(
      authenticated: (user) => user,
      orElse: () => null,
    );
    _nameController = TextEditingController(text: currentUser?.displayName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) {
            setState(() => _isLoading = false);
            Navigator.of(context).pop();
            DialogHandler.showSnackBar(context, message: l10n.changedNameMessage);
          },
          error: (message) {
            setState(() => _isLoading = false);
            ErrorHandler.showAtSnackBar(context, message);
          },
        );
      },
      child: AlertDialog(
        title: Text(l10n.menuChangeName),
        shape: ShapeStyler.DialogShape.outlinedBorder,
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: l10n.displayName,
            border: ShapeStyler.InputShape.inputBorder,
          ),
          autofocus: true,
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
    if (_nameController.text.trim().isNotEmpty) {
      setState(() => _isLoading = true);
      context.read<AuthBloc>().add(
        AuthEvent.updateProfileRequested(displayName: _nameController.text.trim()),
      );
    }
  }
}
