// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:scheck/features/entries/data/datasources/entry_local_data_source.dart'
    as _i583;
import 'package:scheck/features/entries/data/datasources/entry_remote_data_source.dart'
    as _i459;
import 'package:scheck/features/entries/data/datasources/sqflite/sqflite_database.dart'
    as _i57;
import 'package:scheck/features/entries/data/datasources/sqflite/sqflite_entry_local_data_source.dart'
    as _i2;
import 'package:scheck/features/entries/data/datasources/supabase/entry_remote_data_source_mock.dart'
    as _i481;
import 'package:scheck/features/entries/data/repositories/entry_repository_impl.dart'
    as _i160;
import 'package:scheck/features/entries/domain/repositories/entry_repository.dart'
    as _i59;
import 'package:scheck/features/entries/domain/usecases/add_entry.dart'
    as _i292;
import 'package:scheck/features/entries/domain/usecases/get_entries.dart'
    as _i955;
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart'
    as _i988;
import 'package:scheck/features/entries/presentation/pages/meal_registration_page.dart'
    as _i671;
import 'package:scheck/features/entries/presentation/pages/symptom_registration_page.dart'
    as _i955;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i57.SqfliteDatabase>(() => _i57.SqfliteDatabase());
    gh.lazySingleton<_i459.EntryRemoteDataSource>(
      () => _i481.EntryRemoteDataSourceMock(),
    );
    gh.lazySingleton<_i583.EntryLocalDataSource>(
      () => _i2.SqfliteEntryLocalDataSource(gh<_i57.SqfliteDatabase>()),
    );
    gh.lazySingleton<_i59.EntryRepository>(
      () => _i160.EntryRepositoryImpl(
        gh<_i583.EntryLocalDataSource>(),
        gh<_i459.EntryRemoteDataSource>(),
      ),
    );
    gh.factory<_i292.AddEntry>(
      () => _i292.AddEntry(gh<_i59.EntryRepository>()),
    );
    gh.factory<_i955.GetEntries>(
      () => _i955.GetEntries(gh<_i59.EntryRepository>()),
    );
    gh.factory<_i988.EntryBloc>(
      () => _i988.EntryBloc(
        getEntries: gh<_i955.GetEntries>(),
        addEntry: gh<_i292.AddEntry>(),
      ),
    );
    gh.factory<_i671.MealRegistrationBloc>(
      () => _i671.MealRegistrationBloc(addEntry: gh<_i292.AddEntry>()),
    );
    gh.factory<_i955.SymptomRegistrationBloc>(
      () => _i955.SymptomRegistrationBloc(addEntry: gh<_i292.AddEntry>()),
    );
    return this;
  }
}
