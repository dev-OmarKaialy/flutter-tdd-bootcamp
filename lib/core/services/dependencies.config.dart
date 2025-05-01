// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/jokes/data/datasource/local_joke_datasource.dart'
    as _i94;
import '../../features/jokes/data/datasource/remote_joke_datasource.dart'
    as _i767;
import '../../features/jokes/data/repository/joke_repo_impl.dart' as _i224;
import '../../features/jokes/domain/repository/joke_repository.dart' as _i1072;
import '../../features/jokes/domain/usecase/get_random_joke_usecase.dart'
    as _i766;
import '../../features/jokes/presentation/bloc/jokes_bloc.dart' as _i781;
import '../netowrk_info/network_info.dart' as _i916;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final remoteModule = _$RemoteModule();
    final networkModule = _$NetworkModule();
    final localModule = _$LocalModule();
    gh.factory<_i519.Client>(() => remoteModule.client);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
        () => networkModule.instance);
    gh.lazySingletonAsync<_i460.SharedPreferences>(() => localModule.instance);
    gh.factory<_i916.NetworkInfo>(() =>
        _i916.NetworkInfoImpl(instance: gh<_i973.InternetConnectionChecker>()));
    gh.factory<_i767.RemoteJokeDatasource>(() =>
        _i767.RemoteJokeDatasourceImplementation(client: gh<_i519.Client>()));
    gh.factoryAsync<_i94.LocalJokeDatasource>(() async =>
        _i94.LocalDatasourceImplementation(
            sharedPreferences: await getAsync<_i460.SharedPreferences>()));
    gh.factoryAsync<_i1072.JokeRepository>(() async => _i224.JokeRepoImpl(
          info: gh<_i916.NetworkInfo>(),
          localJokeDatasource: await getAsync<_i94.LocalJokeDatasource>(),
          remoteJokeDatasource: gh<_i767.RemoteJokeDatasource>(),
        ));
    gh.factoryAsync<_i766.GetRandomJokeUsecase>(() async =>
        _i766.GetRandomJokeUsecase(
            jokeRepository: await getAsync<_i1072.JokeRepository>()));
    gh.lazySingletonAsync<_i781.JokesBloc>(() async =>
        _i781.JokesBloc(await getAsync<_i766.GetRandomJokeUsecase>()));
    return this;
  }
}

class _$RemoteModule extends _i767.RemoteModule {}

class _$NetworkModule extends _i916.NetworkModule {}

class _$LocalModule extends _i94.LocalModule {}
