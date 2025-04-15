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

import '../../features/app_sections/home/categories/data/data_sources/categories_data_source_contract.dart'
    as _i190;
import '../../features/app_sections/home/categories/data/data_sources/categories_data_source_impl.dart'
    as _i69;
import '../../features/app_sections/home/categories/data/repositories/categories_repo_impl.dart'
    as _i98;
import '../../features/app_sections/home/categories/domain/repositories/categories_repo.dart'
    as _i1000;
import '../../features/app_sections/home/categories/domain/use_cases/get_categories_use_case.dart'
    as _i158;
import '../../features/app_sections/home/categories/presentation/cubit/categories_cubit.dart'
    as _i679;
import '../../features/app_sections/home/occasions/data/data_sources/remote_occasion_data_souce_contract.dart'
    as _i992;
import '../../features/app_sections/home/occasions/data/data_sources/remote_occasion_data_source_impl.dart'
    as _i783;
import '../../features/app_sections/home/occasions/data/repositories/occasion_repo_impl.dart'
    as _i419;
import '../../features/app_sections/home/occasions/domain/repositories/occasion_repo.dart'
    as _i424;
import '../../features/app_sections/home/occasions/domain/use_cases/occasion_use_case.dart'
    as _i1018;
import '../../features/app_sections/home/occasions/domain/use_cases/product_use_case.dart'
    as _i757;
import '../../features/app_sections/home/occasions/presentation/cubit/occasion_cubit.dart'
    as _i157;
import '../../features/auth/login/data/datasource_contract/login_datasource.dart'
    as _i1040;
import '../../features/auth/login/data/datasource_impl/login_datasource_impl.dart'
    as _i675;
import '../../features/auth/login/data/repository_impl/login_repo_impl.dart'
    as _i580;
import '../../features/auth/login/presentation/cubit/login_cubit.dart' as _i126;
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
import '../../features/edit_profile/data/data_sources/remote_profile_datasorce_contract.dart'
    as _i317;
import '../../features/edit_profile/data/data_sources/remote_profile_datasource_impl.dart'
    as _i520;
import '../../features/edit_profile/data/repositories/profile_repo_impl.dart'
    as _i158;
import '../../features/edit_profile/domain/repositories/profile_repo_contract.dart'
    as _i725;
import '../../features/edit_profile/domain/use_cases/update_profile_usecase.dart'
    as _i66;
import '../api_manager/api_manager.dart' as _i266;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i266.ApiManager>(() => _i266.ApiManager());
    gh.singleton<_i126.LoginCubit>(() => _i126.LoginCubit());
    gh.singleton<_i1040.LoginDataSource>(() => _i675.LoginDataSourceImpl());
    gh.singleton<_i317.RemoteProfileDatasorceContract>(
      () => _i520.RemoteProfileDatasourceImpl(gh<_i266.ApiManager>()),
    );
    gh.singleton<_i725.ProfileRepoContract>(
      () => _i158.ProfileRepoImpl(gh<_i317.RemoteProfileDatasorceContract>()),
    );
    gh.factory<_i66.UpdateProfileUsecase>(
      () => _i66.UpdateProfileUsecase(gh<_i725.ProfileRepoContract>()),
    );
    gh.factory<_i992.RemoteOccasionDataSourceContract>(
      () => _i783.RemoteOccasionDataSourceImpl(
        apiManager: gh<_i266.ApiManager>(),
      ),
    );
    gh.factory<_i807.RemoteSignupDataSourceContract>(
      () =>
          _i364.RemoteSignupDataSourceImpl(apiManager: gh<_i266.ApiManager>()),
    );
    gh.singleton<_i580.LoginRepositoryImpl>(
      () => _i580.LoginRepositoryImpl(
        loginDataSource: gh<_i1040.LoginDataSource>(),
      ),
    );
    gh.factory<_i190.CategoriesDataSourceContract>(
      () => _i69.CategoriesDataSourceImpl(apiManager: gh<_i266.ApiManager>()),
    );
    gh.factory<_i1000.CategoriesRepo>(
      () => _i98.CategoriesRepoImpl(
        categoriesDataSourceContract: gh<_i190.CategoriesDataSourceContract>(),
      ),
    );
    gh.factory<_i729.SignupRepo>(
      () => _i234.SignupRepoImpl(
        remoteSignupDataSourceContract:
            gh<_i807.RemoteSignupDataSourceContract>(),
      ),
    );
    gh.factory<_i211.SignupUseCase>(
      () => _i211.SignupUseCase(signupRepo: gh<_i729.SignupRepo>()),
    );
    gh.factory<_i959.SignupCubit>(
      () => _i959.SignupCubit(signupUseCase: gh<_i211.SignupUseCase>()),
    );
    gh.factory<_i424.OccasionRepo>(
      () => _i419.OccasionRepoImpl(
        remoteOccasionDataSourceContract:
            gh<_i992.RemoteOccasionDataSourceContract>(),
      ),
    );
    gh.factory<_i158.GetCategoriesUseCase>(
      () => _i158.GetCategoriesUseCase(repo: gh<_i1000.CategoriesRepo>()),
    );
    gh.factory<_i1018.OccasionUseCase>(
      () => _i1018.OccasionUseCase(occasionRepo: gh<_i424.OccasionRepo>()),
    );
    gh.factory<_i757.ProductsUseCase>(
      () => _i757.ProductsUseCase(gh<_i424.OccasionRepo>()),
    );
    gh.factory<_i679.CategoriesCubit>(
      () => _i679.CategoriesCubit(
        useCase: gh<_i158.GetCategoriesUseCase>(),
        productsUseCase: gh<_i757.ProductsUseCase>(),
      ),
    );
    gh.factory<_i157.OccasionCubit>(
      () => _i157.OccasionCubit(
        occasionUseCase: gh<_i1018.OccasionUseCase>(),
        productsUseCase: gh<_i757.ProductsUseCase>(),
      ),
    );
    return this;
  }
}
