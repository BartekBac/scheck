import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scheck/core/utils/icon_facade.dart';
import 'package:scheck/features/entries/presentation/pages/entries_log_page.dart';
import 'package:scheck/features/entries/presentation/pages/meal_registration_page.dart';
import 'package:scheck/features/entries/presentation/pages/symptom_registration_page.dart';

part 'navigation_bloc.freezed.dart';

enum MenuPage {
  log,
  mealRegister,
  symptomRegister,
}

extension MenuPageExtension on MenuPage {
  String get name => switch (this) {
    MenuPage.log => 'Log',
    MenuPage.mealRegister => 'Meal',
    MenuPage.symptomRegister => 'Symptom',
  };

  IconData get icon => switch (this) {
    MenuPage.log => IconFacade.log,
    MenuPage.mealRegister => IconFacade.meal,
    MenuPage.symptomRegister => IconFacade.symptom,
  };

  Widget get view => switch (this) {
    MenuPage.log => const EntriesLogPage(),
    MenuPage.mealRegister => const MealRegistrationPage(),
    MenuPage.symptomRegister => const SymptomRegistrationPage(),
  };
}

@freezed
sealed class NavigationEvent with _$NavigationEvent {
  const factory NavigationEvent.pageChanged(MenuPage page) = PageChanged;
}

@freezed
sealed class NavigationState with _$NavigationState {
  const factory NavigationState({
    @Default(MenuPage.log) MenuPage page,
  }) = _NavigationState;
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const _NavigationState()) {
    on<PageChanged>((event, emit) {
      emit(state.copyWith(page: event.page));
    });
  }
}
