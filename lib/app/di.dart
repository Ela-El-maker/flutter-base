import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:initial/app/app_prefs.dart';
import 'package:initial/data/data_source/remote_data_source.dart';
import 'package:initial/data/network/app_api.dart';
import 'package:initial/data/network/dio_factory.dart';
import 'package:initial/data/network/network_info.dart';
import 'package:initial/data/repository/repository_impl.dart';
import 'package:initial/domain/repository/repository.dart';
import 'package:initial/domain/usecase/login_usecase.dart';
import 'package:initial/presentation/login/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance  = GetIt.instance;

Future<void> initAppModule() async

{
  final sharedPrefs = await SharedPreferences.getInstance();

// shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(()=> sharedPrefs);

//App prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));


  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(DataConnectionChecker()));

  //dio factory

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

// app service client

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

// remote datasource
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplementer(instance()));

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance()));

}


initLoginModule(){
  if(!GetIt.I.isRegistered<LoginUseCase>())
  {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));

  }
    
}