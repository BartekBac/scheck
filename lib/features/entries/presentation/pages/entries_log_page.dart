import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/stylers/text_styler.dart';
import 'package:scheck/core/utils/icon_facade.dart';
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart';
import 'package:scheck/features/entries/presentation/widgets/entry_card.dart';

class EntriesLogPage extends StatelessWidget {
  const EntriesLogPage({super.key});

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
          if (state.entries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(IconFacade.empty, size: 64, color: ColorStyler.Surface.onColor(context)),
                  SizedBox(height: 16),
                  Text(
                    'No entries yet',
                    style: TextStyler.Headline.medium(context),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start by registering your first meal or symptom',
                    style: TextStyler.Body.medium(context),
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
    );
  }
}