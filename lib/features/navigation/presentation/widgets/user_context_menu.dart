import 'package:flutter/material.dart';
import 'package:scheck/core/utils/icon_facade.dart';
import 'package:scheck/features/navigation/presentation/widgets/dialogs/change_name_dialog.dart';
import 'package:scheck/features/navigation/presentation/widgets/dialogs/logout_dialog.dart';
import 'package:scheck/features/navigation/presentation/widgets/dialogs/reset_password_dialog.dart';
import 'package:scheck/l10n/l10n.dart';

class UserContextMenu extends StatelessWidget {
  const UserContextMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    
    return PopupMenuButton<String>(
      icon: Icon(IconFacade.account),
      onSelected: (String value) {
        switch (value) {
          case 'change_name':
            showDialog(
              context: context,
              builder: (context) => const ChangeNameDialog(),
            );
            break;
          case 'reset_password':
            showDialog(
              context: context,
              builder: (context) => const ResetPasswordDialog(),
            );
            break;
          case 'log_out':
            showDialog(
              context: context,
              builder: (context) => const LogoutDialog(),
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'change_name',
          child: Row(
            children: [
              Icon(IconFacade.edit, size: 20),
              const SizedBox(width: 12),
              Text(l10n.menuChangeName),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'reset_password',
          child: Row(
            children: [
              Icon(IconFacade.lock, size: 20),
              const SizedBox(width: 12),
              Text(l10n.menuResetPassword),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'log_out',
          child: Row(
            children: [
              Icon(IconFacade.logOut, size: 20),
              const SizedBox(width: 12),
              Text(l10n.menuLogOut),
            ],
          ),
        ),
      ],
    );
  }
}
