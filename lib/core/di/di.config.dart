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

import '../../features/app_sections/cart/data/data_sources/carts_contract.dart'
    as _i1027;
import '../../features/app_sections/cart/data/data_sources/carts_impl.dart'
    as _i333;
import '../../features/app_sections/cart/data/repositories/cart_repo_impl.dart'
    as _i938;
import '../../features/app_sections/cart/domain/repositories/update_quantity_repo.dart'
    as _i460;
import '../../features/app_sections/cart/domain/use_cases/get_carts_entity.dart'
    as _i318;
import '../../features/app_sections/cart/domain/use_cases/update_quantity_use_case.dart'
    as _i287;
import '../../features/app_sections/cart/presentation/cubit/cart_cubit.dart'
    as _i204;
import '../../features/app_sections/categories/data/data_sources/categories_data_source_contract.dart'
    as _i510;
import '../../features/app_sections/categories/data/data_sources/categories_data_source_impl.dart'
    as _i337;
import '../../features/app_sections/categories/data/repositories/categories_repo_impl.dart'
    as _i109;
import '../../features/app_sections/categories/domain/repositories/categories_repo.dart'
    as _i509;
import '../../features/app_sections/categories/domain/use_cases/get_categories_use_case.dart'
    as _i66;
import '../../features/app_sections/categories/presentation/cubit/categories_cubit.dart'
    as _i776;
import '../../features/app_sections/occasions/data/data_sources/remote_occasion_data_souce_contract.dart'
    as _i449;
import '../../features/app_sections/occasions/data/data_sources/remote_occasion_data_source_impl.dart'
    as _i683;
import '../../features/app_sections/occasions/data/repositories/occasion_repo_impl.dart'
    as _i129;
import '../../features/app_sections/occasions/domain/repositories/occasion_repo.dart'
    as _i942;
import '../../features/app_sections/occasions/domain/use_cases/occasion_use_case.dart'
    as _i85;
import '../../features/app_sections/occasions/domain/use_cases/product_use_case.dart'
    as _i824;
import '../../features/app_sections/occasions/presentation/cubit/occasion_cubit.dart'
    as _i618;
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
    gh.factory<_i510.CategoriesDataSourceContract>(
      () => _i337.CategoriesDataSourceImpl(apiManager: gh<_i266.ApiManager>()),
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
    gh.factory<_i1027.CartsContract>(
      () => _i333.CartsImpl(apiManager: gh<_i266.ApiManager>()),
    );
    gh.factory<_i449.RemoteOccasionDataSourceContract>(
      () => _i683.RemoteOccasionDataSourceImpl(
        apiManager: gh<_i266.ApiManager>(),
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
    gh.factory<_i460.CartsRepo>(
      () => _i938.CartRepoImpl(dataSource: gh<_i1027.CartsContract>()),
    );
    gh.factory<_i318.GetCartsUseCase>(
      () => _i318.GetCartsUseCase(repo: gh<_i460.CartsRepo>()),
    );
    gh.factory<_i287.UpdateQuantityUseCase>(
      () => _i287.UpdateQuantityUseCase(repo: gh<_i460.CartsRepo>()),
    );
    gh.factory<_i509.CategoriesRepo>(
      () => _i109.CategoriesRepoImpl(
        categoriesDataSourceContract: gh<_i510.CategoriesDataSourceContract>(),
      ),
    );
    gh.factory<_i959.SignupCubit>(
      () => _i959.SignupCubit(signupUseCase: gh<_i211.SignupUseCase>()),
    );
    gh.factory<_i942.OccasionRepo>(
      () => _i129.OccasionRepoImpl(
        remoteOccasionDataSourceContract:
            gh<_i449.RemoteOccasionDataSourceContract>(),
      ),
    );
    gh.factory<_i204.CartCubit>(
      () => _i204.CartCubit(
        useCase: gh<_i287.UpdateQuantityUseCase>(),
        getUseCase: gh<_i318.GetCartsUseCase>(),
      ),
    );
    gh.factory<_i85.OccasionUseCase>(
      () => _i85.OccasionUseCase(occasionRepo: gh<_i942.OccasionRepo>()),
    );
    gh.factory<_i66.GetCategoriesUseCase>(
      () => _i66.GetCategoriesUseCase(repo: gh<_i509.CategoriesRepo>()),
    );
    gh.factory<_i824.ProductsUseCase>(
      () => _i824.ProductsUseCase(gh<_i942.OccasionRepo>()),
    );
    gh.factory<_i776.CategoriesCubit>(
      () => _i776.CategoriesCubit(
        useCase: gh<_i66.GetCategoriesUseCase>(),
        productsUseCase: gh<_i824.ProductsUseCase>(),
      ),
    );
    gh.factory<_i618.OccasionCubit>(
      () => _i618.OccasionCubit(
        occasionUseCase: gh<_i85.OccasionUseCase>(),
        productsUseCase: gh<_i824.ProductsUseCase>(),
      ),
    );
    return this;
  }
}
