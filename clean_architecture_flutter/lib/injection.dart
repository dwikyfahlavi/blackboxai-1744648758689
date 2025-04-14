import 'package:get_it/get_it.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/order/data/datasources/order_remote_data_source.dart';
import 'features/order/data/repositories/order_repository_impl.dart';
import 'features/order/domain/repositories/order_repository.dart';
import 'features/order/domain/usecases/add_order.dart';
import 'features/order/domain/usecases/get_orders.dart';
import 'features/order/presentation/cubit/order_cubit.dart';

final sl = GetIt.instance;

void init() {
  // Features - Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<SignIn>(
    () => SignIn(sl()),
  );

  sl.registerLazySingleton<SignUp>(
    () => SignUp(sl()),
  );

  sl.registerFactory(() => AuthCubit(
        signIn: sl(),
        signUp: sl(),
      ));

  // Features - Order
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<AddOrder>(
    () => AddOrder(sl()),
  );

  sl.registerLazySingleton<GetOrders>(
    () => GetOrders(sl()),
  );

  sl.registerFactory(() => OrderCubit(
        getOrders: sl(),
        addOrder: sl(),
      ));
}
