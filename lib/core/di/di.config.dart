// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/signUp/data/data_sources/remote_signup_data_source_contract.dart'
    as _i807;
import '../../features/auth/signUp/data/data_sources/remote_signup_data_source_impl.dart'
    as _i364;
import '../../features/auth/signUp/data/repositories/signup_repo_impl.dart'
    as _i234;
import '../../features/auth/signUp/domain/repositories/signup_repo.dart'
    as _i729;
import '../../features/auth/signUp/domain/use_cases/signup_use_case.dart'
    as _i211;
import '../../features/auth/signUp/presentation/cubit/signup_cubit.dart'
    as _i959;
import '../api_manager/api_manager.dart' as _i266;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i266.ApiManager>(() => _i266.ApiManager());
    gh.factory<_i807.RemoteSignupDataSourceContract>(() =>
        _i364.RemoteSignupDataSourceImpl(apiManager: gh<_i266.ApiManager>()));
    gh.factory<_i729.SignupRepo>(() => _i234.SignupRepoImpl(
        remoteSignupDataSourceContract:
            gh<_i807.RemoteSignupDataSourceContract>()));
    gh.factory<_i211.SignupUseCase>(
        () => _i211.SignupUseCase(signupRepo: gh<_i729.SignupRepo>()));
    gh.factory<_i959.SignupCubit>(
        () => _i959.SignupCubit(signupUseCase: gh<_i211.SignupUseCase>()));
    return this;
  }
}
