import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/app/app_prefs.dart';
import 'package:shop_app/data/data_source/local_data_source.dart';
import 'package:shop_app/domain/usecase/home_usecase.dart';
import 'package:shop_app/domain/usecase/register_usecase.dart';
import 'package:shop_app/domain/usecase/store_details_usecase.dart';
import 'package:shop_app/presentation/forget_password/viewmodel/forget_password_viewmodel.dart';
import 'package:shop_app/presentation/main/pages/home/home_viewmodel.dart';
import 'package:shop_app/presentation/main/pages/settings/settings_viewmodel.dart';
import 'package:shop_app/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:shop_app/presentation/store_details/viewmodel/store_details_viewmodel.dart';

import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/forget_password_usecase.dart';
import '../domain/usecase/login_usecase.dart';
import '../presentation/login/viewmodel/login_viewmodel.dart';

var instance=GetIt.instance;
Future<void> initAppModule()async{
final shared=await SharedPreferences.getInstance();
instance.registerLazySingleton<SharedPreferences>(() => shared);

instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
// dio factory
instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

// AppServicesClient
    Dio dio=await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServicesClient>(() => AppServicesClient(dio));
// network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

// remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));


  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

// repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(),instance(),instance(),instance()));

// settings
  instance.registerLazySingleton<SettingsViewModel>(() => SettingsViewModel(instance(),instance()));



}

initLoginModule(){
  if(!GetIt.I.isRegistered<LoginUseCase>())
    {
      instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
      instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
    }
}

initForgetPasswordModule(){
  if(!GetIt.I.isRegistered<ForgetPasswordUseCase>())
  {
    instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(() => ForgetPasswordViewModel(instance()));
  }
}

initRegisterModule(){
  if(!GetIt.I.isRegistered<RegisterUseCase>())
  {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule(){
  if(!GetIt.I.isRegistered<HomeUseCase>())
  {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule(){
  if(!GetIt.I.isRegistered<StoreDetailsUseCase>())
  {
    instance.registerFactory<StoreDetailsUseCase>(() => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(() => StoreDetailsViewModel(instance()));
  }
}

// initSettingsModule(){
//   // settings module
//   instance.registerLazySingleton<SettingsViewModel>(() => SettingsViewModel(instance(),instance()));
// }