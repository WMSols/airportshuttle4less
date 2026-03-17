import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:airportshuttle4less/core/config/env_config.dart';
import 'package:airportshuttle4less/core/constants/api_constants.dart';
import 'package:airportshuttle4less/core/network/api_interceptors.dart';
import 'package:airportshuttle4less/core/network/connectivity_service.dart';
import 'package:airportshuttle4less/data/data_sources/local/auth_token_holder.dart';
import 'package:airportshuttle4less/data/data_sources/local/secure_storage_source.dart';
import 'package:airportshuttle4less/data/data_sources/remote/auth_api.dart';
import 'package:airportshuttle4less/data/data_sources/remote/booking_api.dart';
import 'package:airportshuttle4less/data/data_sources/remote/vehicle_api.dart';
import 'package:airportshuttle4less/data/data_sources/remote/payment_api.dart';
import 'package:airportshuttle4less/data/data_sources/remote/support_api.dart';
import 'package:airportshuttle4less/data/repositories/auth_repository_impl.dart';
import 'package:airportshuttle4less/data/repositories/booking_repository_impl.dart';
import 'package:airportshuttle4less/data/repositories/vehicle_repository_impl.dart';
import 'package:airportshuttle4less/data/repositories/payment_repository_impl.dart';
import 'package:airportshuttle4less/data/repositories/support_repository_impl.dart';
import 'package:airportshuttle4less/domain/repositories/auth_repository.dart';
import 'package:airportshuttle4less/domain/repositories/booking_repository.dart';
import 'package:airportshuttle4less/domain/repositories/vehicle_repository.dart';
import 'package:airportshuttle4less/domain/repositories/payment_repository.dart';
import 'package:airportshuttle4less/domain/repositories/support_repository.dart';
import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';
import 'package:airportshuttle4less/domain/use_cases/booking_use_case.dart';
import 'package:airportshuttle4less/domain/use_cases/vehicle_use_case.dart';
import 'package:airportshuttle4less/domain/use_cases/payment_use_case.dart';
import 'package:airportshuttle4less/domain/use_cases/support_use_case.dart';

/// Setup dependency injection using GetX
void setupDependencyInjection() {
  // Core
  final baseUrl = EnvConfig.baseUrl.isNotEmpty
      ? EnvConfig.baseUrl
      : ApiConstants.baseUrl;
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(
        milliseconds: ApiConstants.connectTimeoutMs,
      ),
      receiveTimeout: const Duration(
        milliseconds: ApiConstants.receiveTimeoutMs,
      ),
    ),
  );

  // TODO: Pass getToken and onUnauthorized so authenticated requests get Bearer token
  // and 401 triggers logout. E.g. getToken: () => Get.find<AuthTokenHolder>().accessToken
  dio.interceptors.add(ApiInterceptors());
  Get.put<Dio>(dio);

  // Services
  Get.put<ConnectivityService>(ConnectivityService());

  // Local data sources
  Get.put<AuthTokenHolder>(AuthTokenHolder.instance);
  Get.put<SecureStorageSource>(SecureStorageSource());

  // Remote data sources
  Get.put<AuthApi>(AuthApi(dio));
  Get.put<BookingApi>(BookingApi(dio));
  Get.put<VehicleApi>(VehicleApi(dio));
  Get.put<PaymentApi>(PaymentApi(dio));
  Get.put<SupportApi>(SupportApi(dio));

  // Repositories
  Get.put<AuthRepository>(
    AuthRepositoryImpl(
      api: Get.find<AuthApi>(),
      secureStorage: Get.find<SecureStorageSource>(),
      tokenHolder: Get.find<AuthTokenHolder>(),
    ),
  );
  Get.put<BookingRepository>(
    BookingRepositoryImpl(api: Get.find<BookingApi>()),
  );
  Get.put<VehicleRepository>(
    VehicleRepositoryImpl(api: Get.find<VehicleApi>()),
  );
  Get.put<PaymentRepository>(
    PaymentRepositoryImpl(api: Get.find<PaymentApi>()),
  );
  Get.put<SupportRepository>(
    SupportRepositoryImpl(api: Get.find<SupportApi>()),
  );

  // Use cases
  Get.put<AuthUseCase>(AuthUseCase(Get.find<AuthRepository>()));
  Get.put<BookingUseCase>(BookingUseCase(Get.find<BookingRepository>()));
  Get.put<VehicleUseCase>(VehicleUseCase(Get.find<VehicleRepository>()));
  Get.put<PaymentUseCase>(PaymentUseCase(Get.find<PaymentRepository>()));
  Get.put<SupportUseCase>(SupportUseCase(Get.find<SupportRepository>()));
}
