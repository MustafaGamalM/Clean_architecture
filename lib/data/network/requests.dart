class LoginRequest{
  String email;
  String password;
  LoginRequest(this.email,this.password);
}

class ForgetPasswordRequest{
  String  email;
  ForgetPasswordRequest(this.email);
}

class RegisterRequest {
  String email;
  String password;
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String pictureProfile;

  RegisterRequest(this.email, this.password, this.userName,
      this.countryMobileCode,
      this.mobileNumber, this.pictureProfile);
}