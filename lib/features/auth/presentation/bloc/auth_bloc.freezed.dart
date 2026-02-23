// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _SignInRequested value)?  signInRequested,TResult Function( _SignUpRequested value)?  signUpRequested,TResult Function( _SignOutRequested value)?  signOutRequested,TResult Function( _ResetPasswordRequested value)?  resetPasswordRequested,TResult Function( _UpdateProfileRequested value)?  updateProfileRequested,TResult Function( _AuthStateChanged value)?  authStateChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SignInRequested() when signInRequested != null:
return signInRequested(_that);case _SignUpRequested() when signUpRequested != null:
return signUpRequested(_that);case _SignOutRequested() when signOutRequested != null:
return signOutRequested(_that);case _ResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that);case _UpdateProfileRequested() when updateProfileRequested != null:
return updateProfileRequested(_that);case _AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _SignInRequested value)  signInRequested,required TResult Function( _SignUpRequested value)  signUpRequested,required TResult Function( _SignOutRequested value)  signOutRequested,required TResult Function( _ResetPasswordRequested value)  resetPasswordRequested,required TResult Function( _UpdateProfileRequested value)  updateProfileRequested,required TResult Function( _AuthStateChanged value)  authStateChanged,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _SignInRequested():
return signInRequested(_that);case _SignUpRequested():
return signUpRequested(_that);case _SignOutRequested():
return signOutRequested(_that);case _ResetPasswordRequested():
return resetPasswordRequested(_that);case _UpdateProfileRequested():
return updateProfileRequested(_that);case _AuthStateChanged():
return authStateChanged(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _SignInRequested value)?  signInRequested,TResult? Function( _SignUpRequested value)?  signUpRequested,TResult? Function( _SignOutRequested value)?  signOutRequested,TResult? Function( _ResetPasswordRequested value)?  resetPasswordRequested,TResult? Function( _UpdateProfileRequested value)?  updateProfileRequested,TResult? Function( _AuthStateChanged value)?  authStateChanged,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SignInRequested() when signInRequested != null:
return signInRequested(_that);case _SignUpRequested() when signUpRequested != null:
return signUpRequested(_that);case _SignOutRequested() when signOutRequested != null:
return signOutRequested(_that);case _ResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that);case _UpdateProfileRequested() when updateProfileRequested != null:
return updateProfileRequested(_that);case _AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String email,  String password)?  signInRequested,TResult Function( String email,  String password,  String? displayName)?  signUpRequested,TResult Function()?  signOutRequested,TResult Function( String email)?  resetPasswordRequested,TResult Function( String? displayName,  String? avatarUrl)?  updateProfileRequested,TResult Function( AppUser? user)?  authStateChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SignInRequested() when signInRequested != null:
return signInRequested(_that.email,_that.password);case _SignUpRequested() when signUpRequested != null:
return signUpRequested(_that.email,_that.password,_that.displayName);case _SignOutRequested() when signOutRequested != null:
return signOutRequested();case _ResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that.email);case _UpdateProfileRequested() when updateProfileRequested != null:
return updateProfileRequested(_that.displayName,_that.avatarUrl);case _AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that.user);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String email,  String password)  signInRequested,required TResult Function( String email,  String password,  String? displayName)  signUpRequested,required TResult Function()  signOutRequested,required TResult Function( String email)  resetPasswordRequested,required TResult Function( String? displayName,  String? avatarUrl)  updateProfileRequested,required TResult Function( AppUser? user)  authStateChanged,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _SignInRequested():
return signInRequested(_that.email,_that.password);case _SignUpRequested():
return signUpRequested(_that.email,_that.password,_that.displayName);case _SignOutRequested():
return signOutRequested();case _ResetPasswordRequested():
return resetPasswordRequested(_that.email);case _UpdateProfileRequested():
return updateProfileRequested(_that.displayName,_that.avatarUrl);case _AuthStateChanged():
return authStateChanged(_that.user);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String email,  String password)?  signInRequested,TResult? Function( String email,  String password,  String? displayName)?  signUpRequested,TResult? Function()?  signOutRequested,TResult? Function( String email)?  resetPasswordRequested,TResult? Function( String? displayName,  String? avatarUrl)?  updateProfileRequested,TResult? Function( AppUser? user)?  authStateChanged,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SignInRequested() when signInRequested != null:
return signInRequested(_that.email,_that.password);case _SignUpRequested() when signUpRequested != null:
return signUpRequested(_that.email,_that.password,_that.displayName);case _SignOutRequested() when signOutRequested != null:
return signOutRequested();case _ResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that.email);case _UpdateProfileRequested() when updateProfileRequested != null:
return updateProfileRequested(_that.displayName,_that.avatarUrl);case _AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements AuthEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.started()';
}


}




/// @nodoc


class _SignInRequested implements AuthEvent {
  const _SignInRequested({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInRequestedCopyWith<_SignInRequested> get copyWith => __$SignInRequestedCopyWithImpl<_SignInRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.signInRequested(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$SignInRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$SignInRequestedCopyWith(_SignInRequested value, $Res Function(_SignInRequested) _then) = __$SignInRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$SignInRequestedCopyWithImpl<$Res>
    implements _$SignInRequestedCopyWith<$Res> {
  __$SignInRequestedCopyWithImpl(this._self, this._then);

  final _SignInRequested _self;
  final $Res Function(_SignInRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_SignInRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SignUpRequested implements AuthEvent {
  const _SignUpRequested({required this.email, required this.password, this.displayName});
  

 final  String email;
 final  String password;
 final  String? displayName;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpRequestedCopyWith<_SignUpRequested> get copyWith => __$SignUpRequestedCopyWithImpl<_SignUpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,displayName);

@override
String toString() {
  return 'AuthEvent.signUpRequested(email: $email, password: $password, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$SignUpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$SignUpRequestedCopyWith(_SignUpRequested value, $Res Function(_SignUpRequested) _then) = __$SignUpRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password, String? displayName
});




}
/// @nodoc
class __$SignUpRequestedCopyWithImpl<$Res>
    implements _$SignUpRequestedCopyWith<$Res> {
  __$SignUpRequestedCopyWithImpl(this._self, this._then);

  final _SignUpRequested _self;
  final $Res Function(_SignUpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? displayName = freezed,}) {
  return _then(_SignUpRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _SignOutRequested implements AuthEvent {
  const _SignOutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignOutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.signOutRequested()';
}


}




/// @nodoc


class _ResetPasswordRequested implements AuthEvent {
  const _ResetPasswordRequested(this.email);
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordRequestedCopyWith<_ResetPasswordRequested> get copyWith => __$ResetPasswordRequestedCopyWithImpl<_ResetPasswordRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.resetPasswordRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$ResetPasswordRequestedCopyWith(_ResetPasswordRequested value, $Res Function(_ResetPasswordRequested) _then) = __$ResetPasswordRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$ResetPasswordRequestedCopyWithImpl<$Res>
    implements _$ResetPasswordRequestedCopyWith<$Res> {
  __$ResetPasswordRequestedCopyWithImpl(this._self, this._then);

  final _ResetPasswordRequested _self;
  final $Res Function(_ResetPasswordRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_ResetPasswordRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateProfileRequested implements AuthEvent {
  const _UpdateProfileRequested({this.displayName, this.avatarUrl});
  

 final  String? displayName;
 final  String? avatarUrl;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateProfileRequestedCopyWith<_UpdateProfileRequested> get copyWith => __$UpdateProfileRequestedCopyWithImpl<_UpdateProfileRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateProfileRequested&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,avatarUrl);

@override
String toString() {
  return 'AuthEvent.updateProfileRequested(displayName: $displayName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$UpdateProfileRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$UpdateProfileRequestedCopyWith(_UpdateProfileRequested value, $Res Function(_UpdateProfileRequested) _then) = __$UpdateProfileRequestedCopyWithImpl;
@useResult
$Res call({
 String? displayName, String? avatarUrl
});




}
/// @nodoc
class __$UpdateProfileRequestedCopyWithImpl<$Res>
    implements _$UpdateProfileRequestedCopyWith<$Res> {
  __$UpdateProfileRequestedCopyWithImpl(this._self, this._then);

  final _UpdateProfileRequested _self;
  final $Res Function(_UpdateProfileRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? displayName = freezed,Object? avatarUrl = freezed,}) {
  return _then(_UpdateProfileRequested(
displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _AuthStateChanged implements AuthEvent {
  const _AuthStateChanged(this.user);
  

 final  AppUser? user;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateChangedCopyWith<_AuthStateChanged> get copyWith => __$AuthStateChangedCopyWithImpl<_AuthStateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateChanged&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthEvent.authStateChanged(user: $user)';
}


}

/// @nodoc
abstract mixin class _$AuthStateChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$AuthStateChangedCopyWith(_AuthStateChanged value, $Res Function(_AuthStateChanged) _then) = __$AuthStateChangedCopyWithImpl;
@useResult
$Res call({
 AppUser? user
});




}
/// @nodoc
class __$AuthStateChangedCopyWithImpl<$Res>
    implements _$AuthStateChangedCopyWith<$Res> {
  __$AuthStateChangedCopyWithImpl(this._self, this._then);

  final _AuthStateChanged _self;
  final $Res Function(_AuthStateChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = freezed,}) {
  return _then(_AuthStateChanged(
freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,
  ));
}


}

/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Authenticated value)?  authenticated,TResult Function( _Unauthenticated value)?  unauthenticated,TResult Function( _Error value)?  error,TResult Function( _PasswordResetSent value)?  passwordResetSent,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _Error() when error != null:
return error(_that);case _PasswordResetSent() when passwordResetSent != null:
return passwordResetSent(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Authenticated value)  authenticated,required TResult Function( _Unauthenticated value)  unauthenticated,required TResult Function( _Error value)  error,required TResult Function( _PasswordResetSent value)  passwordResetSent,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Authenticated():
return authenticated(_that);case _Unauthenticated():
return unauthenticated(_that);case _Error():
return error(_that);case _PasswordResetSent():
return passwordResetSent(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Authenticated value)?  authenticated,TResult? Function( _Unauthenticated value)?  unauthenticated,TResult? Function( _Error value)?  error,TResult? Function( _PasswordResetSent value)?  passwordResetSent,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _Error() when error != null:
return error(_that);case _PasswordResetSent() when passwordResetSent != null:
return passwordResetSent(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( AppUser user)?  authenticated,TResult Function()?  unauthenticated,TResult Function( MessageFacade message)?  error,TResult Function()?  passwordResetSent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Authenticated() when authenticated != null:
return authenticated(_that.user);case _Unauthenticated() when unauthenticated != null:
return unauthenticated();case _Error() when error != null:
return error(_that.message);case _PasswordResetSent() when passwordResetSent != null:
return passwordResetSent();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( AppUser user)  authenticated,required TResult Function()  unauthenticated,required TResult Function( MessageFacade message)  error,required TResult Function()  passwordResetSent,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Authenticated():
return authenticated(_that.user);case _Unauthenticated():
return unauthenticated();case _Error():
return error(_that.message);case _PasswordResetSent():
return passwordResetSent();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( AppUser user)?  authenticated,TResult? Function()?  unauthenticated,TResult? Function( MessageFacade message)?  error,TResult? Function()?  passwordResetSent,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Authenticated() when authenticated != null:
return authenticated(_that.user);case _Unauthenticated() when unauthenticated != null:
return unauthenticated();case _Error() when error != null:
return error(_that.message);case _PasswordResetSent() when passwordResetSent != null:
return passwordResetSent();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AuthState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class _Loading implements AuthState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class _Authenticated implements AuthState {
  const _Authenticated(this.user);
  

 final  AppUser user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticatedCopyWith<_Authenticated> get copyWith => __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authenticated&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.authenticated(user: $user)';
}


}

/// @nodoc
abstract mixin class _$AuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthenticatedCopyWith(_Authenticated value, $Res Function(_Authenticated) _then) = __$AuthenticatedCopyWithImpl;
@useResult
$Res call({
 AppUser user
});




}
/// @nodoc
class __$AuthenticatedCopyWithImpl<$Res>
    implements _$AuthenticatedCopyWith<$Res> {
  __$AuthenticatedCopyWithImpl(this._self, this._then);

  final _Authenticated _self;
  final $Res Function(_Authenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_Authenticated(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser,
  ));
}


}

/// @nodoc


class _Unauthenticated implements AuthState {
  const _Unauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class _Error implements AuthState {
  const _Error(this.message);
  

 final  MessageFacade message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 MessageFacade message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as MessageFacade,
  ));
}


}

/// @nodoc


class _PasswordResetSent implements AuthState {
  const _PasswordResetSent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordResetSent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.passwordResetSent()';
}


}




// dart format on
