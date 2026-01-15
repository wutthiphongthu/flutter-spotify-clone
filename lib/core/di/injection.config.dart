// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:flutter_spotify_clone/core/di/modules/network_module.dart'
    as _i264;
import 'package:flutter_spotify_clone/core/di/modules/storage_module.dart'
    as _i632;
import 'package:flutter_spotify_clone/core/network/api.dart' as _i343;
import 'package:flutter_spotify_clone/core/storage/token_storage.dart' as _i741;
import 'package:flutter_spotify_clone/features/auth/data/datasources/apple_auth_provider.dart'
    as _i613;
import 'package:flutter_spotify_clone/features/auth/data/datasources/email_auth_provider.dart'
    as _i758;
import 'package:flutter_spotify_clone/features/auth/data/datasources/google_auth_provider.dart'
    as _i739;
import 'package:flutter_spotify_clone/features/auth/data/repositories/auth_repository_impl.dart'
    as _i348;
import 'package:flutter_spotify_clone/features/auth/domain/repositories/auth_repository.dart'
    as _i759;
import 'package:flutter_spotify_clone/features/auth/domain/usecases/auth_service.dart'
    as _i432;
import 'package:flutter_spotify_clone/features/auth/presentation/bloc/auth_bloc.dart'
    as _i714;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage(),
    );
    gh.lazySingleton<_i613.AppleAuthProvider>(() => _i613.AppleAuthProvider());
    gh.lazySingleton<_i739.GoogleAuthProvider>(
      () => _i739.GoogleAuthProvider(),
    );
    gh.lazySingleton<_i758.EmailAuthProvider>(() => _i758.EmailAuthProvider());
    gh.lazySingleton<_i759.AuthRepository>(
      () => _i348.AuthRepositoryImpl(
        gh<_i758.EmailAuthProvider>(),
        gh<_i739.GoogleAuthProvider>(),
        gh<_i613.AppleAuthProvider>(),
        gh<_i741.TokenStorage>(),
      ),
    );
    gh.lazySingleton<_i741.TokenStorage>(
      () => _i741.TokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i343.ApiClient>(
      () => networkModule.apiClient(gh<_i741.TokenStorage>()),
    );
    gh.lazySingleton<_i432.AuthService>(
      () => _i432.AuthService(gh<_i759.AuthRepository>()),
    );
    gh.factory<_i714.AuthBloc>(() => _i714.AuthBloc(gh<_i432.AuthService>()));
    return this;
  }
}

class _$StorageModule extends _i632.StorageModule {}

class _$NetworkModule extends _i264.NetworkModule {}
