import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:scheck/core/utils/message_facade.dart';
import 'package:scheck/features/auth/domain/entities/app_user.dart';
import 'package:scheck/features/auth/domain/repositories/auth_repository.dart';
import 'package:scheck/features/auth/domain/usecases/get_current_user.dart';
import 'package:scheck/features/auth/domain/usecases/sign_in.dart';
import 'package:scheck/features/auth/domain/usecases/sign_out.dart';
import 'package:scheck/features/auth/domain/usecases/sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final SignIn _signIn;
  final SignUp _signUp;
  final SignOut _signOut;
  final GetCurrentUser _getCurrentUser;

  AuthBloc(
    this._authRepository,
    this._signIn,
    this._signUp,
    this._signOut,
    this._getCurrentUser,
  ) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        started: () => _onStarted(emit),
        signInRequested: (email, password) => _onSignInRequested(email, password, emit),
        signUpRequested: (email, password, displayName) => _onSignUpRequested(email, password, displayName, emit),
        signOutRequested: () => _onSignOutRequested(emit),
        resetPasswordRequested: (email) => _onResetPasswordRequested(email, emit),
        updateProfileRequested: (displayName, avatarUrl) => _onUpdateProfileRequested(displayName, avatarUrl, emit),
        authStateChanged: (user) => _onAuthStateChanged(user, emit),
      );
    });
  }

  Future<void> _onStarted(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final currentUser = await _getCurrentUser();
    if (currentUser != null) {
      emit(AuthState.authenticated(currentUser));
    } else {
      emit(const AuthState.unauthenticated());
    }
    
    await emit.forEach<AppUser?>(
      _authRepository.authStateChanges,
      onData: (user) => user != null 
          ? AuthState.authenticated(user) 
          : const AuthState.unauthenticated(),
      onError: (error, stackTrace) {
        developer.log("Error captured during auth state change listen.", error: error);
        return const AuthState.error(MessageFacade.unexpectedError);
      },
    );
  }

  Future<void> _onSignInRequested(String email, String password, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    try {
      final result = await _signIn(email: email, password: password);
      if(result != null) {
        emit(AuthState.authenticated(result));
      } else {
        emit(const AuthState.error(MessageFacade.signInError));
      }
    } on AuthException catch (e) {
      developer.log("Authentication Exception during sign in. ${e.toString()}");
      emit(const AuthState.error(MessageFacade.signInError));
    } catch (e) {
      developer.log("Exception during sign in. ${e.toString()}");
      emit(const AuthState.error(MessageFacade.unexpectedError));
    }
  }

  Future<void> _onSignUpRequested(String email, String password, String? displayName, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    try {
      final result = await _signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
      if(result != null) {
        emit(AuthState.authenticated(result));
      } else {
      emit(const AuthState.error(MessageFacade.signUpError));
      }
    } on AuthException catch (e) {
      developer.log("Authentication Exception during sign up. ${e.toString()}");
      emit(const AuthState.error(MessageFacade.signUpError));
    } catch (e) {
      developer.log("Exception during sign up. ${e.toString()}");
      emit(const AuthState.error(MessageFacade.unexpectedError));
    }
  }

  Future<void> _onSignOutRequested(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    try {
      final result = await _signOut();
      emit(const AuthState.unauthenticated());
    } catch (e) {
      developer.log("Exception during sign out. ${e.toString()}");
      emit(const AuthState.error(MessageFacade.unexpectedError));
    }
  }

  Future<void> _onResetPasswordRequested(String email, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    try {
      final result = await _authRepository.resetPassword(email);
      emit(const AuthState.passwordResetSent());
    } catch (e) {
        developer.log("Exception during password reset. ${e.toString()}");
        emit(const AuthState.error(MessageFacade.unexpectedError));
    }
  }

  Future<void> _onUpdateProfileRequested(String? displayName, String? avatarUrl, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    try {
      final result = await _authRepository.updateProfile(
        displayName: displayName,
        avatarUrl: avatarUrl,
      );
      emit(AuthState.authenticated(result));
    } catch (e) {
      developer.log("Exception during profile update. ${e.toString()}");
      emit(const AuthState.error(MessageFacade.unexpectedError));
    }
  }

  Future<void> _onAuthStateChanged(AppUser? user, Emitter<AuthState> emit) async {
    if (user != null) {
      emit(AuthState.authenticated(user));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }
}
