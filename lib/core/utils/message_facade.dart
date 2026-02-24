import 'package:scheck/l10n/gen/app_localizations.dart';

enum MessageFacade {
  mealSaveError,
  symptomSaveError,
  signInError,
  signUpError,
  unexpectedError,
  loadEntriesError,
  addEntryError,
  deleteEntryError,
}

extension MessageFacadeExtension on MessageFacade {
  String getMessage(AppLocalizations l10n) => switch(this) {
    MessageFacade.mealSaveError => l10n.errorFailedToSaveMeal,
    MessageFacade.symptomSaveError => l10n.errorFailedToSaveSymptoms,
    MessageFacade.signInError => l10n.errorSignIn,
    MessageFacade.signUpError => l10n.errorSignUp,
    MessageFacade.unexpectedError => l10n.errorUnexpected,
    MessageFacade.loadEntriesError => l10n.errorFailedToLoadEntries,
    MessageFacade.addEntryError => l10n.errorFailedToAddEntry,
    MessageFacade.deleteEntryError => l10n.errorFailedToDeleteEntry,
  };
}