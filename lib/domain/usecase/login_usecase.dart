import 'package:dartz/dartz.dart';
import 'package:shop_app/data/network/failure.dart';
import 'package:shop_app/data/network/requests.dart';
import 'package:shop_app/domain/model/models.dart';
import 'package:shop_app/domain/repository/repository.dart';
import 'package:shop_app/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput , Authentication>{
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput loginUseCaseInput)async {
    return await _repository.login(LoginRequest(loginUseCaseInput.email, loginUseCaseInput.password));
  }

}
class LoginUseCaseInput{
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);
}