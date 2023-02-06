import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shop_app/app/di.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:shop_app/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/routes_manager.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
import 'package:shop_app/presentation/resources/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../resources/assets_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _userPasswordEditingController =
      TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final GlobalKey _formKey = GlobalKey<FormState>();

  _bind() {
    _loginViewModel.start();
    _userNameEditingController.addListener(() {
      _loginViewModel.setUserName(_userNameEditingController.text);
    });
    _userPasswordEditingController.addListener(() {
      _loginViewModel.setPassword(_userPasswordEditingController.text);
    });
    _loginViewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLogged) {
      if (isLogged) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setLoggedIn();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _loginViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, () {
                _loginViewModel.login();
              }, _getContentWidget()) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
        color: ColorManager.white,
        padding: const EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Center(
                  child: Image(image: AssetImage(ImageAssets.splashLogo)),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.userName.tr(),
                            labelText: AppStrings.userName.tr(),
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.userNameError.tr()),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _userPasswordEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.password.tr(),
                            labelText: AppStrings.password.tr(),
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError.tr()),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _loginViewModel.login();
                                }
                              : null,
                          child:  Text(AppStrings.login.tr()),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                        top: AppPadding.p8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.forgetPasswordRoute);
                          },
                          child: Text(
                            AppStrings.forgetPassword.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, Routes.registerRoute);
                          },
                          child: Text(
                            AppStrings.registerText.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }
}
