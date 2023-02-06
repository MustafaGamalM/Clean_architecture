import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:shop_app/domain/usecase/register_usecase.dart';
import 'package:shop_app/presentation/base/baseviewmodel.dart';
import 'package:shop_app/presentation/common/freezed_data_classes.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';

import '../../../app/functions.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/constants_manager.dart';

class RegisterViewModel extends BaseViewModel with RegisterInputs,RegisterOutputs{
  StreamController userNameStreamController = StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController = StreamController<String>.broadcast();
  StreamController mobileNumberStreamController = StreamController<String>.broadcast();
  StreamController profilePictureStreamController = StreamController<File>.broadcast();
  StreamController areAllInputsValidStreamController = StreamController<void>.broadcast();
  final StreamController isUserRegisteredSuccessfullyStreamController=StreamController<void>.broadcast();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("","","","","","");
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }
  @override
  void dispose() {
    userNameStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    mobileNumberStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
    isUserRegisteredSuccessfullyStreamController.close();
    super.dispose();
  }


  @override
  register() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState,message: AppStrings.loading.tr()));

    ( await _registerUseCase.execute(RegisterUseCaseInput(
        registerObject.email,
        registerObject.password,
        registerObject.userName,
        registerObject.countryMobileCode,
        registerObject.mobileNumber,
        registerObject.pictureProfile,
    )))
        .fold((failure) => {
    inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message))
    },
    (data)  {
    // to dismiss any popup loading
    inputState.add(ContentState());
    isUserRegisteredSuccessfullyStreamController.add(true);
    });
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if(_isUserNameValid(userName)){
      registerObject = registerObject.copyWith(userName: userName);
    }else{
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if(isEmailValid(email)){
      registerObject = registerObject.copyWith(email: email);
    }else{
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if(_isMobileNumberValid(mobileNumber)){
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    }else{
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setCountryCode(String countryCode) {
    if(countryCode.isNotEmpty){
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    }else{
      registerObject = registerObject.copyWith(countryMobileCode: AppConstants.egyptCode);
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPasswordValid(password)){
      registerObject = registerObject.copyWith(password: password);
    }else{
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if(profilePicture.path.isNotEmpty){
      registerObject = registerObject.copyWith(pictureProfile: profilePicture.path);
    }else{
      registerObject = registerObject.copyWith(pictureProfile: "");
    }
    validate();
  }

  // inputs

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputPassword =>passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => areAllInputsValidStreamController.sink;


  // outputs

  @override
  Stream<bool> get outputIsUserNameValid => userNameStreamController.stream.map((userName) =>_isUserNameValid(userName) );


  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map((isUserNameValid)=>isUserNameValid ? null : AppStrings.userNameInvalid.tr());


  @override
  Stream<bool> get outputIsEmailValid => emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map((isEmailValid)=>isEmailValid ? null : AppStrings.emailInvalid.tr());
  
  @override
  Stream<bool> get outputIsMobileNumberValid => mobileNumberStreamController.stream.map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>outputIsMobileNumberValid.map((isUserNameValid)=>isUserNameValid ? null : AppStrings.mobileNumberInvalid.tr()) ;
  
  @override
  Stream<bool> get outputIsPasswordValid =>passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map((isUserNameValid)=>isUserNameValid ? null : AppStrings.passwordInvalid.tr());

  @override
  Stream<File> get outputProfilePicture => profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputAreAllInputsValid => areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  // private functions

  bool _isUserNameValid(String userName)
  {
    return userName.length >= 8;
  }

  bool _isPasswordValid(String password)
  {
    return password.length >= 6;
  }

  bool _isMobileNumberValid(String mobileNumber)
  {
    return mobileNumber.length >= 10;
  }

  bool _areAllInputsValid(){
    return registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.pictureProfile.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty ;
  }

  void validate(){
    inputAreAllInputsValid.add(null);
  }


}

abstract class RegisterInputs{
  Sink get inputUserName;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputMobileNumber;
  Sink get inputProfilePicture;
  Sink get inputAreAllInputsValid;

  register();
  setUserName(String userName);
  setEmail(String email);
  setPassword(String password);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setProfilePicture(File profilePicture);


}
abstract class RegisterOutputs{
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputAreAllInputsValid;

}