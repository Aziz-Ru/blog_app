import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserRegister implements UseCase<User, UserRegisterParams> {
  final AuthRepository authRepository;
  const UserRegister(this.authRepository);
  // call the usecase
  // call the repository
  @override
  Future<Either<Failure, User>> call(UserRegisterParams params) async {
    return await authRepository.registerWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserRegisterParams {
  final String email;
  final String password;
  final String name;
  UserRegisterParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
