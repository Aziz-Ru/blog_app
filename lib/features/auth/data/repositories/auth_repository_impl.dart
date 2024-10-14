import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource remoteDatasource;
  const AuthRepositoryImplementation(
    this.remoteDatasource,
  );

  @override
  Future<Either<Failure, User>> registerWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await remoteDatasource.registerWithEmailPassword(
          name: name, email: email, password: password);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> currentUser() {
    throw UnimplementedError();
  }
}
