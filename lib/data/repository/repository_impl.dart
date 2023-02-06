import 'package:dartz/dartz.dart';
import 'package:shop_app/app/app_prefs.dart';
import 'package:shop_app/data/data_source/local_data_source.dart';
import 'package:shop_app/data/mapper/mapper.dart';
import 'package:shop_app/data/network/error_handler.dart';
import 'package:shop_app/data/network/failure.dart';
import 'package:shop_app/data/network/requests.dart';
import 'package:shop_app/data/responses/responses.dart';
import 'package:shop_app/domain/model/models.dart';
import 'package:shop_app/domain/repository/repository.dart';

import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

 class RepositoryImpl implements Repository{

 final  RemoteDataSource _remoteDataSource;
 final LocalDataSource _localDataSource;
 final  NetworkInfo _networkInfo;
 final AppPreferences _appPreferences;
 RepositoryImpl(this._remoteDataSource,this._networkInfo,this._localDataSource,this._appPreferences);
  @override
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest) async{
    if(await _networkInfo.isConnected )
      {
        try{
          final response=await _remoteDataSource.login(loginRequest);
          if(response.status == ApiInternalStatus.SUCCESS)
          {
            return Right(response.toDomain());
          }else
          {
            return Left(Failure(ApiInternalStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));
          }
        }catch(error){
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    else
      {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
  }

  // forget password
  @override
  Future<Either<Failure, ForgetPassword>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest) async{
    if(await _networkInfo.isConnected) {
      try{
        final response = await _remoteDataSource.forgetPassword(forgetPasswordRequest);
        if(response.status == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async{
    if(await _networkInfo.isConnected )
    {
      try{
        final response=await _remoteDataSource.register(registerRequest);
        if(response.status == ApiInternalStatus.SUCCESS)
        {
          return Right(response.toDomain());
        }else
        {
          return Left(Failure(ApiInternalStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async{
    if(await _networkInfo.isConnected )
    {
      try{
        var response =await _localDataSource.getHomeData();
        return Right(response.toDomain());
      }catch(errorCache){
        try{
          final response=await _remoteDataSource.getHomeData();
          if(response.status == ApiInternalStatus.SUCCESS)
          {
             // cache data
            _localDataSource.saveHomeToCache(response);

            _appPreferences.saveHomeDataToCache(response);

            return Right(response.toDomain());
          }else
          {
            return Left(Failure(ApiInternalStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));
          }
        }catch(error){
          return Left(ErrorHandler.handle(error).failure);
        }
      }

    }
    else
    {
     try{
       var response=await _appPreferences.getHomeDataFromCache();
       print(response.toDomain().data.services[0].image);
       print(response.toDomain().data.services[0].title);
       return Right(response.toDomain());
     }catch(error){
       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
     }

    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async{
    if(await _networkInfo.isConnected )
    {
      try{
        final response=await _remoteDataSource.getStoreDetails();
        if(response.status == ApiInternalStatus.SUCCESS)
        {
          return Right(response.toDomain());
        }else
        {
          return Left(Failure(ApiInternalStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }



 }