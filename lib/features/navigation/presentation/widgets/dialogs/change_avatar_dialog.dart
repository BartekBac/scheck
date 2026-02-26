import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scheck/core/stylers/shape_styler.dart';
import 'package:scheck/core/utils/dialog_handler.dart';
import 'package:scheck/core/utils/error_handler.dart';
import 'package:scheck/core/utils/icon_facade.dart';
import 'package:scheck/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scheck/l10n/l10n.dart';

class ChangeAvatarDialog extends StatefulWidget {
  const ChangeAvatarDialog({super.key});

  @override
  State<ChangeAvatarDialog> createState() => _ChangeAvatarDialogState();
}

class _ChangeAvatarDialogState extends State<ChangeAvatarDialog> {
  bool _isLoading = false;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) {
            setState(() => _isLoading = false);
            Navigator.of(context).pop();
            DialogHandler.showSnackBar(context, message: l10n.changedAvatarMessage);
          },
          error: (message) {
            setState(() => _isLoading = false);
            ErrorHandler.showAtSnackBar(context, message);
          },
        );
      },
      child: AlertDialog(
        shape: ShapeStyler.DialogShape.outlinedBorder,
        title: Text(l10n.menuChangeAvatar),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InteractiveViewer(
                        minScale: 1.0,
                        maxScale: 2.0,
                        child: CircleAvatar(
                          radius: 100,
                          foregroundImage: _imageUrl != null ? FileImage(File(_imageUrl!)) : null,
                        ),
                      )
                  ],
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () => _pickImage(ImageSource.camera), icon: Icon(IconFacade.take_photo)),
                IconButton(onPressed: () => _pickImage(ImageSource.gallery), icon: Icon(IconFacade.gallery)),
                IconButton(onPressed: _removeAvatar, icon: Icon(IconFacade.close)),
              ],
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _imageUrl = image.path;
      });
    }
  }

  void _removeAvatar() {
    setState(() => _isLoading = true);
    context.read<AuthBloc>().add(
      const AuthEvent.updateProfileRequested(avatarUrl: ''),
    );
  }
}
