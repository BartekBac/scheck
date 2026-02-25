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
import 'package:scheck/core/services/image_service.dart' as _i883;
import 'package:scheck/core/services/supabase_service.dart' as _i534;
import 'package:scheck/features/auth/data/datasources/supabase_auth_datasource.dart'
    as _i851;
import 'package:scheck/features/auth/data/repositories/auth_repository_impl.dart'
    as _i401;
import 'package:scheck/features/auth/domain/repositories/auth_repository.dart'
    as _i352;
import 'package:scheck/features/auth/domain/usecases/get_current_user.dart'
    as _i520;
import 'package:scheck/features/auth/domain/usecases/sign_in.dart' as _i843;
import 'package:scheck/features/auth/domain/usecases/sign_out.dart' as _i449;
import 'package:scheck/features/auth/domain/usecases/sign_up.dart' as _i818;
import 'package:scheck/features/auth/presentation/bloc/auth_bloc.dart' as _i318;
import 'package:scheck/features/entries/data/datasources/drift/app_drift_database.dart'
    as _i112;
import 'package:scheck/features/entries/data/datasources/drift/drift_entry_local_data_source.dart'
    as _i962;
import 'package:scheck/features/entries/data/datasources/entry_local_data_source.dart'
    as _i583;
import 'package:scheck/features/entries/data/datasources/entry_remote_data_source.dart'
    as _i459;
import 'package:scheck/features/entries/data/datasources/sqflite/sqflite_database.dart'
    as _i57;
import 'package:scheck/features/entries/data/datasources/supabase/entry_remote_data_source_supabase.dart'
    as _i799;
import 'package:scheck/features/entries/data/repositories/entry_repository_impl.dart'
    as _i160;
import 'package:scheck/features/entries/domain/repositories/entry_repository.dart'
    as _i59;
import 'package:scheck/features/entries/domain/usecases/add_entry.dart'
    as _i292;
import 'package:scheck/features/entries/domain/usecases/delete_entry.dart'
    as _i1066;
import 'package:scheck/features/entries/domain/usecases/delete_image.dart'
    as _i666;
import 'package:scheck/features/entries/domain/usecases/get_entries.dart'
    as _i955;
import 'package:scheck/features/entries/domain/usecases/upload_image.dart'
    as _i974;
import 'package:scheck/features/entries/domain/usecases/watch_entries.dart'
    as _i891;
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart'
    as _i988;
import 'package:scheck/features/entries/presentation/pages/meal_registration_page.dart'
    as _i671;
import 'package:scheck/features/entries/presentation/pages/symptom_registration_page.dart'
    as _i955;
import 'package:scheck/features/settings/data/datasources/settings_local_data_source.dart'
    as _i637;
import 'package:scheck/features/settings/data/repositories/settings_repository_impl.dart'
    as _i844;
import 'package:scheck/features/settings/domain/repositories/settings_repository.dart'
    as _i1000;
import 'package:scheck/features/settings/domain/usecases/get_settings.dart'
    as _i65;
import 'package:scheck/features/settings/domain/usecases/save_settings.dart'
    as _i677;
import 'package:scheck/features/settings/presentation/bloc/settings_bloc.dart'
    as _i685;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final supabaseModule = _$SupabaseModule();
    gh.factory<_i112.AppDriftDatabase>(() => _i112.AppDriftDatabase());
    gh.lazySingleton<_i454.SupabaseClient>(() => supabaseModule.supabaseClient);
    gh.lazySingleton<_i57.SqfliteDatabase>(() => _i57.SqfliteDatabase());
    gh.lazySingleton<_i637.SettingsLocalDataSource>(
      () => _i637.SettingsLocalDataSource(),
    );
    gh.lazySingleton<_i583.EntryLocalDataSource>(
      () => _i962.DriftEntryLocalDataSource(gh<_i112.AppDriftDatabase>()),
    );
    gh.lazySingleton<_i883.ImageService>(
      () => _i883.ImageService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i851.AuthDataSource>(
      () => _i851.SupabaseAuthDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i1000.SettingsRepository>(
      () => _i844.SettingsRepositoryImpl(gh<_i637.SettingsLocalDataSource>()),
    );
    gh.lazySingleton<_i65.GetSettings>(
      () => _i65.GetSettings(gh<_i1000.SettingsRepository>()),
    );
    gh.lazySingleton<_i677.SaveSettings>(
      () => _i677.SaveSettings(gh<_i1000.SettingsRepository>()),
    );
    gh.lazySingleton<_i459.EntryRemoteDataSource>(
      () => _i799.EntryRemoteDataSourceSupabase(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i352.AuthRepository>(
      () => _i401.AuthRepositoryImpl(gh<_i851.AuthDataSource>()),
    );
    gh.factory<_i685.SettingsBloc>(
      () =>
          _i685.SettingsBloc(gh<_i65.GetSettings>(), gh<_i677.SaveSettings>()),
    );
    gh.lazySingleton<_i59.EntryRepository>(
      () => _i160.EntryRepositoryImpl(
        gh<_i583.EntryLocalDataSource>(),
        gh<_i459.EntryRemoteDataSource>(),
        gh<_i883.ImageService>(),
      ),
    );
    gh.factory<_i520.GetCurrentUser>(
      () => _i520.GetCurrentUser(gh<_i352.AuthRepository>()),
    );
    gh.factory<_i843.SignIn>(() => _i843.SignIn(gh<_i352.AuthRepository>()));
    gh.factory<_i449.SignOut>(() => _i449.SignOut(gh<_i352.AuthRepository>()));
    gh.factory<_i818.SignUp>(() => _i818.SignUp(gh<_i352.AuthRepository>()));
    gh.factory<_i955.GetEntries>(
      () => _i955.GetEntries(gh<_i59.EntryRepository>()),
    );
    gh.factory<_i318.AuthBloc>(
      () => _i318.AuthBloc(
        gh<_i352.AuthRepository>(),
        gh<_i843.SignIn>(),
        gh<_i818.SignUp>(),
        gh<_i449.SignOut>(),
        gh<_i520.GetCurrentUser>(),
      ),
    );
    gh.factory<_i292.AddEntry>(
      () => _i292.AddEntry(gh<_i59.EntryRepository>()),
    );
    gh.factory<_i1066.DeleteEntry>(
      () => _i1066.DeleteEntry(gh<_i59.EntryRepository>()),
    );
    gh.factory<_i666.DeleteImage>(
      () => _i666.DeleteImage(gh<_i59.EntryRepository>()),
    );
    gh.factory<_i974.UploadImage>(
      () => _i974.UploadImage(gh<_i59.EntryRepository>()),
    );
    gh.factory<_i891.WatchEntries>(
      () => _i891.WatchEntries(gh<_i59.EntryRepository>()),
    );
    gh.factory<_i671.MealRegistrationBloc>(
      () => _i671.MealRegistrationBloc(
        addEntry: gh<_i292.AddEntry>(),
        uploadImage: gh<_i974.UploadImage>(),
        supabaseClient: gh<_i454.SupabaseClient>(),
        imageService: gh<_i883.ImageService>(),
      ),
    );
    gh.factory<_i988.EntryBloc>(
      () => _i988.EntryBloc(
        getEntries: gh<_i955.GetEntries>(),
        addEntry: gh<_i292.AddEntry>(),
        deleteEntry: gh<_i1066.DeleteEntry>(),
        watchEntries: gh<_i891.WatchEntries>(),
        uploadImage: gh<_i974.UploadImage>(),
        deleteImage: gh<_i666.DeleteImage>(),
      ),
    );
    gh.factory<_i955.SymptomRegistrationBloc>(
      () => _i955.SymptomRegistrationBloc(
        addEntry: gh<_i292.AddEntry>(),
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    return this;
  }
}

class _$SupabaseModule extends _i534.SupabaseModule {}
