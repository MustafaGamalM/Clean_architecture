import 'package:dartz/dartz.dart';
import 'package:shop_app/data/network/failure.dart';
import 'package:shop_app/domain/model/models.dart';
import 'package:shop_app/domain/repository/repository.dart';
import 'package:shop_app/domain/usecase/base_usecase.dart';

import '../../data/network/requests.dart';

class ForgetPasswordUseCase implements BaseUseCase<ForgetUseCaseInput , ForgetPassword>{
  final Repository _repository;
  ForgetPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, ForgetPassword>> execute(ForgetUseCaseInput forgetUseCaseInput) async{
    return await _repository.forgetPassword(ForgetPasswordRequest(forgetUseCaseInput.email));
  }

}

class ForgetUseCaseInput{
  String email;
  ForgetUseCaseInput(this.email);
}