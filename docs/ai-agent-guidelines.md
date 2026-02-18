# SCheck AI Agent Development Guidelines

## Quick Reference for AI Agents

### Project Context
- **App**: SCheck - Health tracking app for meals and symptoms
- **Architecture**: Clean Architecture + BLoC + Dependency Injection
- **Tech Stack**: Flutter, Drift, Isar, get_it, freezed, injectable

### Essential Commands
```bash
# Code generation (run after schema/model changes)
flutter packages pub run build_runner build

# Run tests with coverage
very_good test --coverage --test-randomize-ordering-seed random

# Generate localizations
flutter gen-l10n --arb-dir="lib/l10n/arb"

# Run different flavors
flutter run --flavor development --target lib/main_development.dart
flutter run --flavor staging --target lib/main_staging.dart
flutter run --flavor production --target lib/main_production.dart
```

### File Naming Conventions
- **UseCases**: `action_entity.dart` (e.g., `add_entry.dart`)
- **BLoCs**: `feature_bloc.dart`
- **Pages**: `feature_page.dart` (snake_case)
- **Models**: `entity.dart` (e.g., `entry.dart`)
- **Repositories**: `entity_repository.dart` (interface) and `entity_repository_impl.dart` (implementation)

### Code Templates

#### New Feature Structure
```
features/
└── new_feature/
    ├── data/
    │   ├── datasources/
    │   ├── models/
    │   └── repositories/
    ├── domain/
    │   ├── entities/
    │   ├── repositories/
    │   └── usecases/
    └── presentation/
        ├── bloc/
        └── pages/
```

#### BLoC Template
```dart
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_feature_bloc.freezed.dart';

@freezed
sealed class NewFeatureEvent with _$NewFeatureEvent {
  const factory NewFeatureEvent.action() = Action;
}

@freezed
sealed class NewFeatureState with _$NewFeatureState {
  const factory NewFeatureState({
    @Default(Status.initial) Status status,
    String? error,
  }) = _NewFeatureState;
}

class NewFeatureBloc extends Bloc<NewFeatureEvent, NewFeatureState> {
  NewFeatureBloc() : super(const _NewFeatureState()) {
    on<Action>((event, emit) async {
      // Handle event
    });
  }
}
```

#### UseCase Template
```dart
import 'package:injectable/injectable.dart';

@injectable
class ActionEntity {
  final EntityRepository _repository;
  
  ActionEntity(this._repository);
  
  Future<ReturnType> call(Params params) async {
    return await _repository.method(params);
  }
}
```

### Key Patterns

#### Dependency Injection
- Always use `@injectable` annotation
- Place in `lib/injection.dart` configuration
- Run build_runner after adding new dependencies

#### Error Handling
```dart
try {
  final result = await usecase(params);
  emit(state.copyWith(status: Status.success, data: result));
} catch (e) {
  emit(state.copyWith(status: Status.failure, error: e.toString()));
}
```

#### Localization
```dart
// Add to lib/l10n/arb/app_en.arb
"newKey": "Translated text",
"@newKey": {
  "description": "Description for translators"
}

// Use in code
final l10n = context.l10n;
Text(l10n.newKey)
```

### Common Imports
```dart
// State management
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Code generation
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Project imports
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/l10n/gen/app_localizations.dart';
```

### Testing Patterns
```dart
// UseCase test
test('should perform action', () async {
  // Arrange
  final mockRepository = MockEntityRepository();
  final usecase = ActionEntity(mockRepository);
  
  // Act
  await usecase(params);
  
  // Assert
  verify(mockRepository.method(params)).called(1);
});

// BLoC test
blocTest<NewFeatureBloc, NewFeatureState>(
  'should emit success when action succeeds',
  build: () => NewFeatureBloc(),
  act: (bloc) => bloc.add(const NewFeatureEvent.action()),
  expect: () => [const NewFeatureState(status: Status.success)],
);
```

### Database Patterns

#### Drift (SQL)
```dart
@DataClassName('Entity')
class EntityTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
}
```

#### Isar (Object Storage)
```dart
@collection
class Entity {
  Id id = Isar.autoIncrement;
  late String name;
  late DateTime createdAt;
}
```

### Icon Usage
Use `IconFacade` for consistent icons:
```dart
Icon(IconFacade.meal)      // For meal-related
Icon(IconFacade.symptom)   // For symptom-related
Icon(IconFacade.log)       // For logs/lists
```

### Navigation
Use `NavigationBloc` for app navigation:
```dart
context.read<NavigationBloc>().add(
  const NavigationEvent.pageChanged(MenuPage.targetPage)
);
```

### What to Avoid
- Don't break Clean Architecture boundaries
- Don't hardcode strings (use localization)
- Don't forget to run code generation
- Don't use setState (use BLoC instead)
- Don't ignore error handling

### When to Run Code Generation
After modifying:
- freezed classes
- injectable dependencies
- drift schemas
- json_serializable classes
- localization files

### Performance Tips
- Use const constructors
- Implement lazy loading
- Optimize image loading
- Monitor memory usage
