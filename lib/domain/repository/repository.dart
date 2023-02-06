

import 'package:shop_app/data/network/failure.dart';
import 'package:shop_app/domain/model/models.dart';

import '../../data/network/requests.dart';
import 'package:dartz/dartz.dart';

abstract class Repository{
 Future<Either<Failure , Authentication>> login(LoginRequest loginRequest);
 Future<Either<Failure , ForgetPassword>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest);
 Future<Either<Failure , Authentication>> register(RegisterRequest registerRequest);
 Future<Either<Failure , HomeObject>> getHomeData();
 Future<Either<Failure , StoreDetails>> getStoreDetails();
}