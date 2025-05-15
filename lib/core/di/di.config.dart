// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/address/data/data_source/data_source.dart' as _i514;
import '../../features/address/data/data_source_impl/data_source_impl.dart'
    as _i794;
import '../../features/address/data/repo_impl/address_repo_impl.dart' as _i778;
import '../../features/address/domain/repo/address_repo.dart' as _i366;
import '../../features/address/domain/use_cases/add_address.dart' as _i280;
import '../../features/address/domain/use_cases/get_cities_use_case.dart'
    as _i573;
import '../../features/address/domain/use_cases/get_current_address_info.dart'
    as _i403;
import '../../features/address/domain/use_cases/get_permission.dart' as _i512;
import '../../features/address/domain/use_cases/get_state_use_case.dart'
    as _i340;
import '../../features/address/presentation/cubits/address_cubit/address_cubit.dart'
    as _i177;
import '../../features/app_sections/cart/data/data_sources/carts_contract.dart'
    as _i1027;
import '../../features/app_sections/cart/data/data_sources/carts_impl.dart'
    as _i333;
import '../../features/app_sections/cart/data/repositories/cart_repo_impl.dart'
    as _i938;
import '../../features/app_sections/cart/domain/repositories/cart_repo.dart'
    as _i112;
import '../../features/app_sections/cart/domain/use_cases/delete_cart_use_case.dart'
    as _i886;
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
import '../../features/app_sections/home/data/data_sources_contract/home_datasource.dart'
    as _i593;
import '../../features/app_sections/home/data/data_sources_impl/home_datasource_impl.dart'
    as _i409;
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
import '../../features/app_sections/search/data/data_sources/search_data_source.dart'
    as _i190;
import '../../features/app_sections/search/data/data_sources/search_data_source_impl.dart'
    as _i891;
import '../../features/app_sections/search/data/repositories/search_repo_impl.dart'
    as _i859;
import '../../features/app_sections/search/domain/repositories/search_repo.dart'
    as _i67;
import '../../features/app_sections/search/domain/use_cases/get_products_by_search.dart'
    as _i887;
import '../../features/app_sections/search/presentation/cubit/search_cubit.dart'
    as _i596;
import '../../features/auth/change_password/data/api_call/api_call.dart'
    as _i663;
import '../../features/auth/change_password/data/data_source/contract/change_password_data_source_contract.dart'
    as _i107;
import '../../features/auth/change_password/data/data_source/remote/change_password_data_source.dart'
    as _i879;
import '../../features/auth/change_password/data/repository/change_password_repository.dart'
    as _i419;
import '../../features/auth/change_password/domain/repository/change_password_repository_interface.dart'
    as _i1013;
import '../../features/auth/change_password/domain/use_case/change_password_use_case.dart'
    as _i370;
import '../../features/auth/change_password/presentation/cubit/change_password_cubit.dart'
    as _i81;
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
import '../../features/checkout_page/data/data_source/contract/cash_contract/cash_order_datasource_contract.dart'
    as _i841;
import '../../features/checkout_page/data/data_source/contract/credit_contract/credit_order_datasource_contract.dart'
    as _i976;
import '../../features/checkout_page/data/data_source/remote/cash_remote/cash_order_datasource_remote.dart'
    as _i1009;
import '../../features/checkout_page/data/data_source/remote/credit_remote/credit_order_datasource_remote.dart'
    as _i413;
import '../../features/checkout_page/data/repository/cash_repo_impl/cash_repository_impl.dart'
    as _i979;
import '../../features/checkout_page/data/repository/credit_repo_impl/credit_repository_impl.dart'
    as _i769;
import '../../features/checkout_page/data/service/cash_api_call/cash_order_service.dart'
    as _i552;
import '../../features/checkout_page/data/service/credit_api_call/credit_order_service.dart'
    as _i945;
import '../../features/checkout_page/domain/repository/cash_repo/cash_order_repository.dart'
    as _i27;
import '../../features/checkout_page/domain/repository/credit_repo/credit_order_repository.dart'
    as _i303;
import '../../features/checkout_page/domain/use_case/cash_usecase/cash_use_case.dart'
    as _i1048;
import '../../features/checkout_page/domain/use_case/credit_usecase/credit_use_case.dart'
    as _i1066;
import '../../features/checkout_page/presentation/cubit/checkout_cubit.dart'
    as _i862;
import '../../features/checkout_page/presentation/cubit/payment_cubit.dart'
    as _i796;
import '../../features/checkout_page/presentation/cubit/select_address_cubit.dart'
    as _i711;
import '../../features/localization/data/data_source/data_source.dart' as _i254;
import '../../features/localization/data/data_source_impl/data_source_impl.dart'
    as _i178;
import '../../features/localization/domain/use_cases/get_language.dart'
    as _i702;
import '../../features/localization/domain/use_cases/set_language.dart'
    as _i565;
import '../../features/saved_address/data/data_sources/remote_address_ds_contract.dart'
    as _i541;
import '../../features/saved_address/data/data_sources/remote_address_ds_impl.dart'
    as _i836;
import '../../features/saved_address/data/repositories/address_repo_impl.dart'
    as _i896;
import '../../features/saved_address/domain/repositories/address_repo_contract.dart'
    as _i496;
import '../../features/saved_address/domain/usecases/add_address_usecase.dart'
    as _i685;
import '../../features/saved_address/domain/usecases/delete_address_usecase.dart'
    as _i498;
import '../../features/saved_address/domain/usecases/get_addresses_usecase.dart'
    as _i150;
import '../../features/saved_address/domain/usecases/update_address_usecase.dart'
    as _i722;
import '../../features/saved_address/presentation/view_model/address_cubit.dart'
    as _i146;
import '../../features/splash/data/auto_login_data_source/auto_login_data_source.dart'
    as _i537;
import '../../features/splash/data/auto_login_data_source_imp/auto_login_data_source_impl.dart'
    as _i975;
import '../../features/splash/data/auto_login_repo_imp/auto_login_repo_imp.dart'
    as _i146;
import '../../features/splash/domain/auto_login_repo/auto_login_repo.dart'
    as _i372;
import '../../features/splash/domain/use_cases/get_user_data.dart' as _i595;
import '../api_manager/api_manager.dart' as _i266;
import '../cubits/local_cubit/local_cubit.dart' as _i691;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i796.PaymentMethodCubit>(() => _i796.PaymentMethodCubit());
    gh.factory<_i711.SelectAddressCubit>(() => _i711.SelectAddressCubit());
    gh.singleton<_i361.Dio>(() => registerModule.dio());
    gh.singleton<_i126.LoginCubit>(() => _i126.LoginCubit());
    gh.singleton<_i1040.LoginDataSource>(() => _i675.LoginDataSourceImpl());
    gh.singleton<_i266.ApiManager>(() => _i266.ApiManager(gh<_i361.Dio>()));
    gh.factory<_i254.LocalDataSource>(() => _i178.LocalDataSourceImpl());
    gh.singleton<_i945.CreditOrderService>(
      () => _i945.CreditOrderService(apiManager: gh<_i266.ApiManager>()),
    );
    gh.singleton<_i552.CashOrderService>(
      () => _i552.CashOrderService(apiManager: gh<_i266.ApiManager>()),
    );
    gh.singleton<_i663.ChangePasswordService>(
      () => _i663.ChangePasswordService(apiManager: gh<_i266.ApiManager>()),
    );
    gh.factory<_i976.CreditOrderDatasourceContract>(
      () => _i413.CreditCheckoutServiceRemote(
        checkoutService: gh<_i945.CreditOrderService>(),
      ),
    );
    gh.factory<_i702.GetLanguageUseCase>(
      () => _i702.GetLanguageUseCase(gh<_i254.LocalDataSource>()),
    );
    gh.factory<_i565.SetLanguageUseCase>(
      () => _i565.SetLanguageUseCase(gh<_i254.LocalDataSource>()),
    );
    gh.factory<_i510.CategoriesDataSourceContract>(
      () => _i337.CategoriesDataSourceImpl(apiManager: gh<_i266.ApiManager>()),
    );
    gh.factory<_i593.HomeDataSources>(
      () => _i409.HomeDataSourceImpl(apiManager: gh<_i266.ApiManager>()),
    );
    gh.factory<_i190.SearchDataSource>(
      () => _i891.SearchDataSourceImpl(apiManager: gh<_i266.ApiManager>()),
    );
    gh.factory<_i107.ChangePasswordContract>(
      () => _i879.ChangePasswordRemoteDataSource(
        changePasswordService: gh<_i663.ChangePasswordService>(),
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
    gh.factory<_i541.RemoteAddressDsContract>(
      () => _i836.RemoteAddressDsImpl(gh<_i266.ApiManager>()),
    );
    gh.factory<_i691.LocalizationCubit>(
      () => _i691.LocalizationCubit(
        gh<_i702.GetLanguageUseCase>(),
        gh<_i565.SetLanguageUseCase>(),
      ),
    );
    gh.factory<_i112.CartsRepo>(
      () => _i938.CartRepoImpl(dataSource: gh<_i1027.CartsContract>()),
    );
    gh.factory<_i537.AutoLoginDataSource>(
      () => _i975.AutoLoginDataSourceImp(gh<_i266.ApiManager>()),
    );
    gh.factory<_i514.AddressDataSource>(
      () => _i794.DataSourceImpl(gh<_i266.ApiManager>()),
    );
    gh.factory<_i211.SignupUseCase>(
      () => _i211.SignupUseCase(signupRepo: gh<_i729.SignupRepo>()),
    );
    gh.factory<_i67.SearchRepo>(
      () => _i859.SearchRepoImpl(dataSource: gh<_i190.SearchDataSource>()),
    );
    gh.factory<_i366.AddressRepo>(
      () => _i778.AddressRepoImpl(gh<_i514.AddressDataSource>()),
    );
    gh.factory<_i496.AddressRepoContract>(
      () => _i896.AddressRepoImpl(gh<_i541.RemoteAddressDsContract>()),
    );
    gh.factory<_i303.CreditOrderRepository>(
      () => _i769.CreditOrderRepoImpl(
        creditCheckoutServiceContract:
            gh<_i976.CreditOrderDatasourceContract>(),
      ),
    );
    gh.factory<_i841.CashCheckoutServiceContract>(
      () => _i1009.CashCheckoutServiceRemote(
        checkoutPageService: gh<_i552.CashOrderService>(),
      ),
    );
    gh.factory<_i886.DeleteCartUseCase>(
      () => _i886.DeleteCartUseCase(repo: gh<_i112.CartsRepo>()),
    );
    gh.factory<_i287.UpdateQuantityUseCase>(
      () => _i287.UpdateQuantityUseCase(repo: gh<_i112.CartsRepo>()),
    );
    gh.factory<_i318.GetCartsUseCase>(
      () => _i318.GetCartsUseCase(repo: gh<_i112.CartsRepo>()),
    );
    gh.factory<_i509.CategoriesRepo>(
      () => _i109.CategoriesRepoImpl(
        categoriesDataSourceContract: gh<_i510.CategoriesDataSourceContract>(),
      ),
    );
    gh.factory<_i887.GetProductsBySearch>(
      () => _i887.GetProductsBySearch(repo: gh<_i67.SearchRepo>()),
    );
    gh.factory<_i1013.ChangePasswordRepository>(
      () => _i419.ChangePasswordRepositoryImpl(
        changePasswordContract: gh<_i107.ChangePasswordContract>(),
      ),
    );
    gh.factory<_i1066.CreditOrderUseCase>(
      () => _i1066.CreditOrderUseCase(
        orderRepository: gh<_i303.CreditOrderRepository>(),
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
    gh.factory<_i596.SearchCubit>(
      () => _i596.SearchCubit(useCase: gh<_i887.GetProductsBySearch>()),
    );
    gh.factory<_i372.AutoLoginRepo>(
      () => _i146.AutoLoginRepoImp(gh<_i537.AutoLoginDataSource>()),
    );
    gh.factory<_i573.GetCitiesUseCase>(
      () => _i573.GetCitiesUseCase(gh<_i366.AddressRepo>()),
    );
    gh.factory<_i340.GetStateUseCase>(
      () => _i340.GetStateUseCase(gh<_i366.AddressRepo>()),
    );
    gh.factory<_i512.GetPermissionUseCase>(
      () => _i512.GetPermissionUseCase(gh<_i366.AddressRepo>()),
    );
    gh.factory<_i280.AddAddressUseCase>(
      () => _i280.AddAddressUseCase(gh<_i366.AddressRepo>()),
    );
    gh.factory<_i403.GetCurrentAddressInfo>(
      () => _i403.GetCurrentAddressInfo(gh<_i366.AddressRepo>()),
    );
    gh.factory<_i177.AddressCubit>(
      () => _i177.AddressCubit(
        gh<_i403.GetCurrentAddressInfo>(),
        gh<_i512.GetPermissionUseCase>(),
        gh<_i573.GetCitiesUseCase>(),
        gh<_i340.GetStateUseCase>(),
      ),
    );
    gh.factory<_i85.OccasionUseCase>(
      () => _i85.OccasionUseCase(occasionRepo: gh<_i942.OccasionRepo>()),
    );
    gh.factory<_i27.CashOrderRepository>(
      () => _i979.CashOrderRepoImpl(
        cashCheckoutServiceContract: gh<_i841.CashCheckoutServiceContract>(),
      ),
    );
    gh.factory<_i722.UpdateAddressUsecase>(
      () => _i722.UpdateAddressUsecase(gh<_i496.AddressRepoContract>()),
    );
    gh.factory<_i498.DeleteAddressUsecase>(
      () => _i498.DeleteAddressUsecase(gh<_i496.AddressRepoContract>()),
    );
    gh.factory<_i150.GetAddressesUsecase>(
      () => _i150.GetAddressesUsecase(gh<_i496.AddressRepoContract>()),
    );
    gh.factory<_i685.AddAddressUsecase>(
      () => _i685.AddAddressUsecase(gh<_i496.AddressRepoContract>()),
    );
    gh.factory<_i370.ChangePasswordUseCase>(
      () => _i370.ChangePasswordUseCase(
        repository: gh<_i1013.ChangePasswordRepository>(),
      ),
    );
    gh.factory<_i81.ChangePasswordCubit>(
      () => _i81.ChangePasswordCubit(
        changePasswordUseCase: gh<_i370.ChangePasswordUseCase>(),
      ),
    );
    gh.factory<_i66.GetCategoriesUseCase>(
      () => _i66.GetCategoriesUseCase(repo: gh<_i509.CategoriesRepo>()),
    );
    gh.factory<_i204.CartCubit>(
      () => _i204.CartCubit(
        updateUseCase: gh<_i287.UpdateQuantityUseCase>(),
        getUseCase: gh<_i318.GetCartsUseCase>(),
        deleteCartUseCase: gh<_i886.DeleteCartUseCase>(),
      ),
    );
    gh.factory<_i1048.CashOrderUseCase>(
      () => _i1048.CashOrderUseCase(
        orderRepository: gh<_i27.CashOrderRepository>(),
      ),
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
    gh.factory<_i595.GetUserDataUseCase>(
      () => _i595.GetUserDataUseCase(gh<_i372.AutoLoginRepo>()),
    );
    gh.factory<_i146.SavedAddressCubit>(
      () => _i146.SavedAddressCubit(
        gh<_i685.AddAddressUsecase>(),
        gh<_i150.GetAddressesUsecase>(),
        gh<_i722.UpdateAddressUsecase>(),
        gh<_i498.DeleteAddressUsecase>(),
      ),
    );
    gh.factory<_i862.CheckoutCubit>(
      () => _i862.CheckoutCubit(
        cashOrderUseCase: gh<_i1048.CashOrderUseCase>(),
        creditOrderUseCase: gh<_i1066.CreditOrderUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i266.RegisterModule {}
