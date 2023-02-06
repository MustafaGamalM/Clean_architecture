import 'package:shop_app/data/network/requests.dart';
import 'package:shop_app/data/responses/responses.dart';

import '../network/app_api.dart';
// i will do dependency inversion


// abstract class ===> وسيط بين height level && low level
abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<ForgetPasswordResponse> forgetPassword(ForgetPasswordRequest forgetPasswordRequest);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<HomeResponse> getHomeData();

  Future<StoreDetailsResponse> getStoreDetails();

}


class RemoteDataSourceImpl implements RemoteDataSource{
  final AppServicesClient _appServicesClient;
  RemoteDataSourceImpl(this._appServicesClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
   return await _appServicesClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(ForgetPasswordRequest forgetPasswordRequest)async {
    return await _appServicesClient.forgetPassword(forgetPasswordRequest.email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest)async {
    return await _appServicesClient.register(registerRequest.userName, registerRequest.countryMobileCode, registerRequest.mobileNumber,
        registerRequest.email,registerRequest. password,
        "");
    // registerRequest.pictureProfile دا ناقص
  }

  @override
  Future<HomeResponse> getHomeData() async{
    return await _appServicesClient.getHomeData();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async{
    return await _appServicesClient.getStoreDetails();
  }
}

