import 'package:dartz/dartz.dart';
import 'package:shop_app/data/network/failure.dart';
import 'package:shop_app/data/network/requests.dart';
import 'package:shop_app/domain/model/models.dart';
import 'package:shop_app/domain/repository/repository.dart';
import 'package:shop_app/domain/usecase/base_usecase.dart';
import 'package:shop_app/presentation/resources/constants_manager.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput , Authentication>{
  final Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput registerUseCaseInput)async {
    return await _repository.register(RegisterRequest(registerUseCaseInput.email, registerUseCaseInput.password, registerUseCaseInput.userName,
        registerUseCaseInput.countryMobileCode , registerUseCaseInput.mobileNumber, registerUseCaseInput.pictureProfile));
  }

}
class RegisterUseCaseInput{
  String email;
  String password;
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String pictureProfile;

  RegisterUseCaseInput(this.email, this.password, this.userName,
      this.countryMobileCode,
      this.mobileNumber, this.pictureProfile);
}