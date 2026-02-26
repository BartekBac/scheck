import 'package:flutter/material.dart';
import 'package:scheck/core/utils/icon_facade.dart';
import 'package:scheck/features/navigation/presentation/widgets/dialogs/change_avatar_dialog.dart';
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
      /*BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            authenticated: (user) => user.avatarUrl != null ? Image.file(File(user.avatarUrl!)) : const Icon(IconFacade.account),
              orElse: () => const Icon(IconFacade.account)
          );
        },
      ),*/
      onSelected: (String value) {
        switch (value) {
          case 'change_avatar':
            showDialog(
              context: context,
              builder: (context) => const ChangeAvatarDialog(),
            );
            break;
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
        //TODO: add change avatar functionality
        /*PopupMenuItem<String>(
          value: 'change_avatar',
          child: Row(
            children: [
              Icon(IconFacade.account, size: 20),
              const SizedBox(width: 12),
              Text(l10n.menuChangeAvatar),
            ],
          ),
        ),*/
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
