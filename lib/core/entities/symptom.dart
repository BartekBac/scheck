import 'package:scheck/l10n/l10n.dart';

enum Symptom {
  abdominalPain('Abdominal pain'),
  bloating('Bloating'),
  nausea('Nausea'),
  heartburn('Heartburn'),
  diarrhea('Diarrhea'),
  constipation('Constipation'),
  fatigue('Fatigue'),
  headache('Headache'),
  jointPain('Joint pain'),
  skinRash('Skin rash'),
  anxiety('Anxiety'),
  brainFog('Brain fog');

  const Symptom(this.key);
  final String key;

  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case Symptom.abdominalPain:
        return l10n.symptomAbdominalPain;
      case Symptom.bloating:
        return l10n.symptomBloating;
      case Symptom.nausea:
        return l10n.symptomNausea;
      case Symptom.heartburn:
        return l10n.symptomHeartburn;
      case Symptom.diarrhea:
        return l10n.symptomDiarrhea;
      case Symptom.constipation:
        return l10n.symptomConstipation;
      case Symptom.fatigue:
        return l10n.symptomFatigue;
      case Symptom.headache:
        return l10n.symptomHeadache;
      case Symptom.jointPain:
        return l10n.symptomJointPain;
      case Symptom.skinRash:
        return l10n.symptomSkinRash;
      case Symptom.anxiety:
        return l10n.symptomAnxiety;
      case Symptom.brainFog:
        return l10n.symptomBrainFog;
    }
  }
}
