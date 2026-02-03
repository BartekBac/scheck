import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart';
import 'package:scheck/features/entries/presentation/widgets/entry_card.dart';
import 'package:scheck/injection.dart';

class EntriesLogPage extends StatelessWidget {
  const EntriesLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entries Log'),
        elevation: 0,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: BlocProvider( //TODO: it should be provided once?
        create: (context) => getIt<EntryBloc>()..add(LoadEntries()),
        child: BlocBuilder<EntryBloc, EntryState>(
          builder: (context, state) {
            if (state is EntryLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is EntryError) {
              return Center(child: Text(state.message));
            }
            if (state is EntryLoaded) {
              if (state.entries.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.book, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No entries yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Start by registering your first meal or symptom',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.entries.length,
                itemBuilder: (context, index) {
                  final entry = state.entries[index];
                  return EntryCard(entry: entry);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}