import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shop_app/app/di.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:shop_app/presentation/forget_password/viewmodel/forget_password_viewmodel.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
import 'package:shop_app/presentation/resources/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../resources/routes_manager.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
 final TextEditingController _userNameController=TextEditingController();
  final ForgetPasswordViewModel _forgetPasswordViewModel = instance<ForgetPasswordViewModel>();
 final AppPreferences _appPreferences=instance<AppPreferences>();
 final GlobalKey _myKey=GlobalKey<FormState>();
 _bind(){
    _forgetPasswordViewModel.start();
    _userNameController.addListener(() {
      _forgetPasswordViewModel.setEmail(_userNameController.text);});
    _forgetPasswordViewModel.isResetPasswordSuccessfullyStreamController.stream.map((isReseted) {
      if(isReseted)
        {
          SchedulerBinding.instance.addPostFrameCallback((_) {
           //_appPreferences.setLoggedIn();
            Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
          });
        }
    });
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  void dispose() {
    _forgetPasswordViewModel.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(elevation: AppSize.s0,backgroundColor:ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primary),),
      body: StreamBuilder<FlowState>(
        stream: _forgetPasswordViewModel.outputState,
        builder: (context, snapshot) =>  snapshot.data?.getScreenWidget(context,(){_forgetPasswordViewModel.forgetPassword();},_getContentWidget())??_getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget(){
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: AppSize.s40,left: AppSize.s10,right: AppSize.s10),
        color: ColorManager.white,
        child: Form(
          key: _myKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(ImageAssets.splashLogo),
              const SizedBox(height: AppSize.s20,),
              StreamBuilder<bool>(
                stream: _forgetPasswordViewModel.outputEmail,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType:TextInputType.emailAddress,
                    controller:_userNameController,
                    decoration: InputDecoration(hintText: AppStrings.email.tr(),
                      labelText:AppStrings.email.tr(),errorText:(snapshot.data ?? true)?  null:AppStrings.passwordError.tr()
                  ),
                  );
                },),
              const SizedBox(height: AppSize.s20,),
              StreamBuilder<bool>(
                stream: _forgetPasswordViewModel.outputEmail,
                builder: (context, snapshot) {
                return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed:
                    ( snapshot.data ?? false )? (){
                      _forgetPasswordViewModel.forgetPassword();
                    } : null,child: Text(AppStrings.resetPassword.tr()),));
              },),
              const SizedBox(height: AppSize.s20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text(AppStrings.didNotReceiveEmail.tr()),
                TextButton(onPressed: (){

                }, child: Text(AppStrings.resend.tr(),style: Theme.of(context).textTheme.titleMedium,))
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
