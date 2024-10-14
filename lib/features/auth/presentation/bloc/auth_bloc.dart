import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // register usecase

  final UserRegister _userRegister;

  AuthBloc({required UserRegister userRegister})
      : _userRegister = userRegister,
        super(AuthInitial()) {
    
    on<AuthSignUp>((event, emit) async {
      // call the usecase
      emit(AuthLoading());
      final result = await _userRegister(UserRegisterParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ));
      print(result);
      result.fold(
        (l) => emit(AuthFailure(l.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });
  }

  // @override
  // void onChange(Change<AuthState> change) {
  //   print(change);
  //   super.onChange(change);
  // }
}
