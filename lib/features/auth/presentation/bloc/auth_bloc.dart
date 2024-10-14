import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // register usecase

  final UserRegister _userRegister;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc(
      {required UserRegister userRegister,
      required UserLogin userLogin,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userRegister = userRegister,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final result = await _userRegister(UserRegisterParams(
      email: event.email,
      password: event.password,
      name: event.name,
    ));
    // print(result);
    result.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(AuthSignIn event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());

    final result = await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    ));
    print(result);

    result.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final result = await _currentUser(NoParams());
    result.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) {
        // print(user.email);
        _emitAuthSuccess(user, emit);
      },
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
