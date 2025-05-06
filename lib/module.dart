import 'package:bloc_restapi_app/bloc/get/getcontact/getcontact_cubit.dart';
import 'package:bloc_restapi_app/data/api/apiservice.dart';
import 'package:bloc_restapi_app/data/contact_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

var getIt = GetIt.I;
void locator() {
  Dio dio = Dio();
  getIt.registerLazySingleton(() => dio);

  ApiService apiService = ApiService(getIt.call());
  getIt.registerLazySingleton(() => apiService);

  ContactRepository contactRepository = ContactRepository(getIt.call());
  getIt.registerLazySingleton(() => contactRepository);

  GetcontactCubit getcontactCubit = GetcontactCubit(getIt.call());
  getIt.registerLazySingleton(() => getcontactCubit);
}
