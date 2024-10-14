import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteImplemention implements AuthRemoteDataSource {
  final SupabaseClient remoteDataSource;
  AuthRemoteImplemention(this.remoteDataSource);

  @override
  Session? get currentUserSession => remoteDataSource.auth.currentSession;

  @override
  Future<UserModel> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final existEmail =
          await remoteDataSource.from('profiles').select().eq('email', email);

      if (existEmail.isNotEmpty) {
        throw const AuthException('Email already exist!');
      }
      final response = await remoteDataSource.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      // print(response);
      if (response.user == null) {
        throw const ServerException('User is null!');
      }

      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      // print(e.message);
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException('Email is not exist!');
      }

      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await remoteDataSource.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );
        return UserModel.fromJson(userData.first);
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
