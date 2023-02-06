// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginObject {
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String userName, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$_LoginObjectCopyWith(
          _$_LoginObject value, $Res Function(_$_LoginObject) then) =
      __$$_LoginObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userName, String password});
}

/// @nodoc
class __$$_LoginObjectCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$_LoginObject>
    implements _$$_LoginObjectCopyWith<$Res> {
  __$$_LoginObjectCopyWithImpl(
      _$_LoginObject _value, $Res Function(_$_LoginObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? password = null,
  }) {
    return _then(_$_LoginObject(
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginObject implements _LoginObject {
  _$_LoginObject(this.userName, this.password);

  @override
  final String userName;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(userName: $userName, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginObject &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      __$$_LoginObjectCopyWithImpl<_$_LoginObject>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String userName, final String password) =
      _$_LoginObject;

  @override
  String get userName;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ForgetPasswordObject {
  String get email => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ForgetPasswordObjectCopyWith<ForgetPasswordObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgetPasswordObjectCopyWith<$Res> {
  factory $ForgetPasswordObjectCopyWith(ForgetPasswordObject value,
          $Res Function(ForgetPasswordObject) then) =
      _$ForgetPasswordObjectCopyWithImpl<$Res, ForgetPasswordObject>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$ForgetPasswordObjectCopyWithImpl<$Res,
        $Val extends ForgetPasswordObject>
    implements $ForgetPasswordObjectCopyWith<$Res> {
  _$ForgetPasswordObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ForgetPasswordObjectCopyWith<$Res>
    implements $ForgetPasswordObjectCopyWith<$Res> {
  factory _$$_ForgetPasswordObjectCopyWith(_$_ForgetPasswordObject value,
          $Res Function(_$_ForgetPasswordObject) then) =
      __$$_ForgetPasswordObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$_ForgetPasswordObjectCopyWithImpl<$Res>
    extends _$ForgetPasswordObjectCopyWithImpl<$Res, _$_ForgetPasswordObject>
    implements _$$_ForgetPasswordObjectCopyWith<$Res> {
  __$$_ForgetPasswordObjectCopyWithImpl(_$_ForgetPasswordObject _value,
      $Res Function(_$_ForgetPasswordObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$_ForgetPasswordObject(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ForgetPasswordObject implements _ForgetPasswordObject {
  _$_ForgetPasswordObject(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'ForgetPasswordObject(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForgetPasswordObject &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ForgetPasswordObjectCopyWith<_$_ForgetPasswordObject> get copyWith =>
      __$$_ForgetPasswordObjectCopyWithImpl<_$_ForgetPasswordObject>(
          this, _$identity);
}

abstract class _ForgetPasswordObject implements ForgetPasswordObject {
  factory _ForgetPasswordObject(final String email) = _$_ForgetPasswordObject;

  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_ForgetPasswordObjectCopyWith<_$_ForgetPasswordObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterObject {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get countryMobileCode => throw _privateConstructorUsedError;
  String get mobileNumber => throw _privateConstructorUsedError;
  String get pictureProfile => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res, RegisterObject>;
  @useResult
  $Res call(
      {String email,
      String password,
      String userName,
      String countryMobileCode,
      String mobileNumber,
      String pictureProfile});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res, $Val extends RegisterObject>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? userName = null,
    Object? countryMobileCode = null,
    Object? mobileNumber = null,
    Object? pictureProfile = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      countryMobileCode: null == countryMobileCode
          ? _value.countryMobileCode
          : countryMobileCode // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      pictureProfile: null == pictureProfile
          ? _value.pictureProfile
          : pictureProfile // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegisterObjectCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$$_RegisterObjectCopyWith(
          _$_RegisterObject value, $Res Function(_$_RegisterObject) then) =
      __$$_RegisterObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      String userName,
      String countryMobileCode,
      String mobileNumber,
      String pictureProfile});
}

/// @nodoc
class __$$_RegisterObjectCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res, _$_RegisterObject>
    implements _$$_RegisterObjectCopyWith<$Res> {
  __$$_RegisterObjectCopyWithImpl(
      _$_RegisterObject _value, $Res Function(_$_RegisterObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? userName = null,
    Object? countryMobileCode = null,
    Object? mobileNumber = null,
    Object? pictureProfile = null,
  }) {
    return _then(_$_RegisterObject(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == countryMobileCode
          ? _value.countryMobileCode
          : countryMobileCode // ignore: cast_nullable_to_non_nullable
              as String,
      null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      null == pictureProfile
          ? _value.pictureProfile
          : pictureProfile // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RegisterObject implements _RegisterObject {
  _$_RegisterObject(this.email, this.password, this.userName,
      this.countryMobileCode, this.mobileNumber, this.pictureProfile);

  @override
  final String email;
  @override
  final String password;
  @override
  final String userName;
  @override
  final String countryMobileCode;
  @override
  final String mobileNumber;
  @override
  final String pictureProfile;

  @override
  String toString() {
    return 'RegisterObject(email: $email, password: $password, userName: $userName, countryMobileCode: $countryMobileCode, mobileNumber: $mobileNumber, pictureProfile: $pictureProfile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterObject &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.countryMobileCode, countryMobileCode) ||
                other.countryMobileCode == countryMobileCode) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.pictureProfile, pictureProfile) ||
                other.pictureProfile == pictureProfile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password, userName,
      countryMobileCode, mobileNumber, pictureProfile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegisterObjectCopyWith<_$_RegisterObject> get copyWith =>
      __$$_RegisterObjectCopyWithImpl<_$_RegisterObject>(this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  factory _RegisterObject(
      final String email,
      final String password,
      final String userName,
      final String countryMobileCode,
      final String mobileNumber,
      final String pictureProfile) = _$_RegisterObject;

  @override
  String get email;
  @override
  String get password;
  @override
  String get userName;
  @override
  String get countryMobileCode;
  @override
  String get mobileNumber;
  @override
  String get pictureProfile;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterObjectCopyWith<_$_RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}
