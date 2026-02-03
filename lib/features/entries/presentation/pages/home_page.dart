import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart';
import 'package:scheck/features/entries/presentation/pages/entries_log_page.dart';
import 'package:scheck/features/entries/presentation/pages/meal_registration_page.dart';
import 'package:scheck/features/entries/presentation/pages/symptom_registration_page.dart';
import 'package:scheck/injection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<EntryBloc>()..add(LoadEntries()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meal Feel'),
          elevation: 0,
        ),
        body: const HomeContent(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Explicitly set the type
          selectedItemColor: Theme.of(context).colorScheme.primary, // Use theme colors
          unselectedItemColor: Colors.grey,
          currentIndex: 0,
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
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MealRegistrationPage()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SymptomRegistrationPage()),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EntriesLogPage()),
                );
                break;
            }
          },
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, EntryState>(
      builder: (context, state) {
        if (state is EntryLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is EntryError) {
          return Center(child: Text(state.message));
        }
        if (state is EntryLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.entries.length,
                  itemBuilder: (context, index) {
                    final entry = state.entries[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(entry.timestamp.toString().substring(0, 16)),
                        subtitle: Text(
                          switch(entry) {
                            MealEntry _ => 'Meal: ${entry.mealType.name}',
                            SymptomEntry _ => 'Symptoms: ${entry.symptoms.join(", ")}',
                            Entry _ => throw UnimplementedError(),
                          }
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // TODO: Navigate to entry details
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}