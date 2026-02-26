import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart';
import 'package:scheck/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:scheck/features/navigation/presentation/widgets/app_bar_title.dart';
import 'package:scheck/features/navigation/presentation/widgets/user_context_menu.dart';
import 'package:scheck/injection.dart';
import 'package:scheck/l10n/l10n.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()..add(const AuthEvent.started())),
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(
          create: (context) => getIt<EntryBloc>()..add(EntriesSubscriptionRequested()),
        ),
      ],
      child: const NavigationView(),
    );
  }
}

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const AppBarTitle(),
            elevation: 0,
            actions: const [UserContextMenu()],
          ),
          body: IndexedStack(
            index: state.page.index,
            children: MenuPage.values.map((page) => page.view).toList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state.page.index,
            onTap: (index) =>
                context.read<NavigationBloc>().add(PageChanged(MenuPage.values[index])),
            items: MenuPage.values
                .map((page) => BottomNavigationBarItem(
                      icon: Icon(page.icon),
                      label: page.getName(context.l10n),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}

