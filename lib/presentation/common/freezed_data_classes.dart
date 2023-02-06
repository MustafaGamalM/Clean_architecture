import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';
@freezed
class LoginObject with _$LoginObject
{
  factory LoginObject(String userName,String password) = _LoginObject;
}

@freezed

class ForgetPasswordObject with _$ForgetPasswordObject
{
  factory ForgetPasswordObject(String email) = _ForgetPasswordObject;
}

@freezed
class RegisterObject with _$RegisterObject
{
  factory RegisterObject(
      String email,
      String password,
      String userName,
      String countryMobileCode,
      String mobileNumber,
      String pictureProfile) = _RegisterObject;
}