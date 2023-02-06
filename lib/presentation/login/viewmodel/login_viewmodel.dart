import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:shop_app/presentation/base/baseviewmodel.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../domain/usecase/login_usecase.dart';
import '../../common/freezed_data_classes.dart';
import '../../resources/strings_manager.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs , LoginViewModelOutputs
{
 final StreamController _userStreamController=StreamController<String>.broadcast();
 final StreamController _passwordStreamController=StreamController<String>.broadcast();
 LoginObject loginObject=LoginObject("","");
 final StreamController _areAllInputsValidStreamController=StreamController<void>.broadcast();
 final StreamController isUserLoggedInSuccessfullyStreamController=StreamController<void>.broadcast();

 final LoginUseCase _loginUseCase;
 LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _userStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }
 // inputs

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;


 @override
 setPassword(String password) {
   inputPassword.add(password);
   loginObject =loginObject.copyWith(password: password);
   inputAreAllInputsValid.add(null);
 }

 @override
 setUserName(String userName) {
   inputUserName.add(userName);
   loginObject =loginObject.copyWith(userName: userName);
   inputAreAllInputsValid.add(null);
 }

 @override
  login() async{
   inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState,message:  AppStrings.loading.tr()));
  ( await _loginUseCase.execute(LoginUseCaseInput(loginObject.userName,loginObject.password)))
      .fold((failure) => {
    inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message))
          },
          (data)  {
        // to dismiss any popup loading
            inputState.add(ContentState());
            isUserLoggedInSuccessfullyStreamController.add(true);
          });
 }
 // outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((password) =>_isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid =>_userStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outAreAllInputsValid => _areAllInputsValidStreamController.stream.map((event) =>_areAllValid() );

  bool _isPasswordValid(String password)
  {
    return password.isNotEmpty;
  }
 bool _isUserNameValid(String userName)
 {
   return userName.isNotEmpty;
 }

 bool _areAllValid(){
    return _isPasswordValid(loginObject.password) && _isUserNameValid(loginObject.userName);
 }
}

abstract class LoginViewModelInputs{
  setUserName(String username);
  setPassword(String password);
  login();
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}
abstract class LoginViewModelOutputs{
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputsValid;

}