import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_register.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Register your dependencies here
  // serviceLocator.registerSingleton<YourService>(YourService());
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteImplemention(serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImplementation(serviceLocator()));

  serviceLocator.registerFactory(() => UserRegister(serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => AuthBloc(userRegister: serviceLocator()));
}
