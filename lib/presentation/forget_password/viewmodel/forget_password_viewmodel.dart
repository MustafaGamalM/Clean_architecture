import 'dart:async';

import 'package:shop_app/domain/usecase/forget_password_usecase.dart';
import 'package:shop_app/presentation/base/baseviewmodel.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';

import '../../common/freezed_data_classes.dart';

class ForgetPasswordViewModel extends BaseViewModel with ForgetPasswordViewModelInputs,ForgetPasswordViewModelOutputs{
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController isResetPasswordSuccessfullyStreamController = StreamController<bool>.broadcast();

  final ForgetPasswordUseCase forgetPasswordUseCase;
  ForgetPasswordObject forgetPasswordObject = ForgetPasswordObject("");
  ForgetPasswordViewModel(this.forgetPasswordUseCase);
  @override
  void start() {
    inputState.add(ContentState());
  }
  @override
  void dispose() {
    _emailStreamController.close();
    isResetPasswordSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  forgetPassword() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
  ( await forgetPasswordUseCase.execute(ForgetUseCaseInput(forgetPasswordObject.email)))
      .fold((failure) {
    inputState.add(ErrorState(StateRendererType.popupErrorState,failure.message));
              },
          (data) {
            inputState.add(SuccessState(data.support??AppStrings.success));
            isResetPasswordSuccessfullyStreamController.add(true);
          });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    forgetPasswordObject = forgetPasswordObject.copyWith(email: email);

    //todo i will do something
  }
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outputEmail => _emailStreamController.stream.map((email) =>_checkIsPasswordValid(email) ) ;

  bool _checkIsPasswordValid(String email){
    return email.isNotEmpty ;
  }

}

abstract class ForgetPasswordViewModelInputs{
  Sink get  inputEmail;
  setEmail(String email);
  forgetPassword();
}

abstract class ForgetPasswordViewModelOutputs{
Stream<bool> get outputEmail;
}