import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:shop_app/app/constatnts.dart';
import 'package:shop_app/data/responses/responses.dart';
part 'app_api.g.dart';
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient{
factory AppServicesClient(Dio dio, {String baseUrl}) = _AppServicesClient;
@POST("/customers/login")
Future<AuthenticationResponse> login(@Field('email') String email,@Field('password') String password);

@POST("/customers/forgetPassword")
Future<ForgetPasswordResponse> forgetPassword(@Field('email') String email);

@POST("/customers/register")
Future<AuthenticationResponse> register(
    @Field('user_name') String userName,
    @Field('country_mobile_code') String countryMobileCode,
    @Field('mobile_number') String mobileNumber,
    @Field('email') String email,
    @Field('password') String password,
    @Field('picture_profile') String pictureProfile,
    );

@GET("/home")
Future<HomeResponse> getHomeData();

@GET("/storeDetails/1")
Future<StoreDetailsResponse> getStoreDetails();
}