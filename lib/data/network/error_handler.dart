import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shop_app/data/network/failure.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
class ErrorHandler implements Exception{
  late Failure failure;
  ErrorHandler.handle(dynamic error){
    if(error is DioError)
      {
        failure = _handleError(error);
      }else
        {
          failure = DataSource.DEFAULT.getFailure();
        }
  }
  Failure _handleError(DioError error){
   switch(error.type){
     case DioErrorType.connectTimeout:
       return DataSource.CONNECT_TIMEOUT.getFailure();
     case DioErrorType.sendTimeout:
       return DataSource.SEND_TIMEOUT.getFailure();
     case DioErrorType.receiveTimeout:
       return DataSource.RECIEVE_TIMEOUT.getFailure();
     case DioErrorType.response:
      if(error.response != null && error.response?.statusCode != null && error.response?.statusMessage !=null){
       return Failure(error.response?.statusCode ??0, error.response?.statusMessage??"");
      }else{
        return DataSource.DEFAULT.getFailure();
      }
     case DioErrorType.cancel:
       return DataSource.CANCEL.getFailure();
     case DioErrorType.other:
       return DataSource.DEFAULT.getFailure();
   }
  }
}
enum DataSource{
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}
extension DataSourceExtension on DataSource{
  Failure getFailure(){
    switch(this){
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS.tr());
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.N0_CONTENT, ResponseMessage.N0_CONTENT.tr());
      case DataSource.BAD_REQUEST:
      return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST.tr());
      case DataSource.FORBIDDEN:
      return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN.tr());
      case DataSource.UNAUTORISED:
      return Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED.tr());
      case DataSource.NOT_FOUND:
      return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND.tr());
      case DataSource.INTERNAL_SERVER_ERROR:
      return Failure(ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR.tr());
      case DataSource.CONNECT_TIMEOUT:
      return Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT.tr());
      case DataSource.CANCEL:
      return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL.tr());
      case DataSource.RECIEVE_TIMEOUT:
      return Failure(ResponseCode.RECIEVE, ResponseMessage.RECIEVE.tr());
      case DataSource.SEND_TIMEOUT:
      return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT.tr());
      case DataSource.CACHE_ERROR:
      return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR.tr());
      case DataSource.NO_INTERNET_CONNECTION:
      return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION.tr());
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT.tr());
    }
  }
}

class ResponseCode{
  static const int SUCCESS = 200; // success with data
  static const int N0_CONTENT = 201; //success with on content
  static const int BAD_REQUEST = 400; // failure api
  static const int FORBIDDEN = 401; //api reject
  static const int UNAUTORISED = 403; //user un authorized
  static const int INTERNAL_SERVER_ERROR = 500; //crash in server
  static const int NOT_FOUND=404;
  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;

}

class  ResponseMessage{
  static const String SUCCESS = AppStrings.success; // success with data
  static const String N0_CONTENT = AppStrings.noContentError; //success with on content
  static const String BAD_REQUEST = AppStrings.badRequestError; // failure api
  static const String FORBIDDEN = AppStrings.forbiddenError; //api reject
  static const String UNAUTORISED = AppStrings.unauthorizedError; //user un authorized
  static const String INTERNAL_SERVER_ERROR = AppStrings.internalServerError; //crash in server
  static const String NOT_FOUND= AppStrings.notFoundError;
  // local status code
  static const String CONNECT_TIMEOUT = AppStrings.connectionTimeOutError;
  static const String CANCEL = AppStrings.cancelError;
  static const String RECIEVE = AppStrings.receiveError;
  static const String SEND_TIMEOUT = AppStrings.sendTimeOutError;
  static const String CACHE_ERROR = AppStrings.cacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetConnectionError;
  static const String DEFAULT = AppStrings.defaultError;

}