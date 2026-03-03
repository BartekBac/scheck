// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EntryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EntryState()';
}


}

/// @nodoc
class $EntryStateCopyWith<$Res>  {
$EntryStateCopyWith(EntryState _, $Res Function(EntryState) __);
}


/// Adds pattern-matching-related methods to [EntryState].
extension EntryStatePatterns on EntryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EntryInitial value)?  initial,TResult Function( EntryLoading value)?  loading,TResult Function( EntryLoaded value)?  loaded,TResult Function( EntryError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EntryInitial() when initial != null:
return initial(_that);case EntryLoading() when loading != null:
return loading(_that);case EntryLoaded() when loaded != null:
return loaded(_that);case EntryError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EntryInitial value)  initial,required TResult Function( EntryLoading value)  loading,required TResult Function( EntryLoaded value)  loaded,required TResult Function( EntryError value)  error,}){
final _that = this;
switch (_that) {
case EntryInitial():
return initial(_that);case EntryLoading():
return loading(_that);case EntryLoaded():
return loaded(_that);case EntryError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EntryInitial value)?  initial,TResult? Function( EntryLoading value)?  loading,TResult? Function( EntryLoaded value)?  loaded,TResult? Function( EntryError value)?  error,}){
final _that = this;
switch (_that) {
case EntryInitial() when initial != null:
return initial(_that);case EntryLoading() when loading != null:
return loading(_that);case EntryLoaded() when loaded != null:
return loaded(_that);case EntryError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Entry> entries)?  loaded,TResult Function( MessageFacade error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EntryInitial() when initial != null:
return initial();case EntryLoading() when loading != null:
return loading();case EntryLoaded() when loaded != null:
return loaded(_that.entries);case EntryError() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Entry> entries)  loaded,required TResult Function( MessageFacade error)  error,}) {final _that = this;
switch (_that) {
case EntryInitial():
return initial();case EntryLoading():
return loading();case EntryLoaded():
return loaded(_that.entries);case EntryError():
return error(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Entry> entries)?  loaded,TResult? Function( MessageFacade error)?  error,}) {final _that = this;
switch (_that) {
case EntryInitial() when initial != null:
return initial();case EntryLoading() when loading != null:
return loading();case EntryLoaded() when loaded != null:
return loaded(_that.entries);case EntryError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class EntryInitial implements EntryState {
  const EntryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EntryState.initial()';
}


}




/// @nodoc


class EntryLoading implements EntryState {
  const EntryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EntryState.loading()';
}


}




/// @nodoc


class EntryLoaded implements EntryState {
  const EntryLoaded(final  List<Entry> entries): _entries = entries;
  

 final  List<Entry> _entries;
 List<Entry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of EntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntryLoadedCopyWith<EntryLoaded> get copyWith => _$EntryLoadedCopyWithImpl<EntryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryLoaded&&const DeepCollectionEquality().equals(other._entries, _entries));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries));

@override
String toString() {
  return 'EntryState.loaded(entries: $entries)';
}


}

/// @nodoc
abstract mixin class $EntryLoadedCopyWith<$Res> implements $EntryStateCopyWith<$Res> {
  factory $EntryLoadedCopyWith(EntryLoaded value, $Res Function(EntryLoaded) _then) = _$EntryLoadedCopyWithImpl;
@useResult
$Res call({
 List<Entry> entries
});




}
/// @nodoc
class _$EntryLoadedCopyWithImpl<$Res>
    implements $EntryLoadedCopyWith<$Res> {
  _$EntryLoadedCopyWithImpl(this._self, this._then);

  final EntryLoaded _self;
  final $Res Function(EntryLoaded) _then;

/// Create a copy of EntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? entries = null,}) {
  return _then(EntryLoaded(
null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<Entry>,
  ));
}


}

/// @nodoc


class EntryError implements EntryState {
  const EntryError(this.error);
  

 final  MessageFacade error;

/// Create a copy of EntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntryErrorCopyWith<EntryError> get copyWith => _$EntryErrorCopyWithImpl<EntryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'EntryState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $EntryErrorCopyWith<$Res> implements $EntryStateCopyWith<$Res> {
  factory $EntryErrorCopyWith(EntryError value, $Res Function(EntryError) _then) = _$EntryErrorCopyWithImpl;
@useResult
$Res call({
 MessageFacade error
});




}
/// @nodoc
class _$EntryErrorCopyWithImpl<$Res>
    implements $EntryErrorCopyWith<$Res> {
  _$EntryErrorCopyWithImpl(this._self, this._then);

  final EntryError _self;
  final $Res Function(EntryError) _then;

/// Create a copy of EntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(EntryError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as MessageFacade,
  ));
}


}

// dart format on
