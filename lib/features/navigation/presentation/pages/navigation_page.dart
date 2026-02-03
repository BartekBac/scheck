import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart';
import 'package:scheck/features/entries/presentation/pages/entries_log_page.dart';
import 'package:scheck/features/entries/presentation/pages/home_page.dart';
import 'package:scheck/features/entries/presentation/pages/meal_registration_page.dart';
import 'package:scheck/features/entries/presentation/pages/symptom_registration_page.dart';
import 'package:scheck/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:scheck/injection.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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

  static const List<Widget> _pages = <Widget>[
    HomeContent(),
    MealRegistrationPage(),
    SymptomRegistrationPage(),
    EntriesLogPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Meal Feel'), // TODO: This should be dynamic
            elevation: 0,
          ),
          body: IndexedStack(
            index: state.pageIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            currentIndex: state.pageIndex,
            onTap: (index) =>
                context.read<NavigationBloc>().add(PageChanged(index)),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: 'Meal',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sick),
                label: 'Symptom',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Log',
              ),
            ],
          ),
        );
      },
    );
  }
}
