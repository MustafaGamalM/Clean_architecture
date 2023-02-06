import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/app/di.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:shop_app/presentation/login/view/login_view.dart';
import 'package:shop_app/presentation/main/main_veiw.dart';
import 'package:shop_app/presentation/main/pages/home/home_page.dart';
import 'package:shop_app/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/constants_manager.dart';
import 'package:shop_app/presentation/resources/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberTextEditingController =
      TextEditingController();

  _bind() {
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });
    _emailTextEditingController.addListener(() {
      _viewModel.setEmail(_emailTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });
    _mobileNumberTextEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberTextEditingController.text);
    });
    _viewModel.setCountryCode(AppConstants.egyptCode);

    _viewModel.isUserRegisteredSuccessfullyStreamController.stream
        .listen((isRegistered) {
      if (isRegistered) {
        SchedulerBinding.instance?.addPostFrameCallback((_) {
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
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, () {
                _viewModel.register();
              }, _getContentWidget()) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
        color: ColorManager.white,
        padding: const EdgeInsets.only(top: AppPadding.p28),
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
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameTextEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.userName.tr(),
                            labelText: AppStrings.userName.tr(),
                            errorText: (snapshot.data)),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s17,
                ),
                Center(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (country) {
                              _viewModel.setCountryCode(
                                  country.dialCode ?? AppConstants.egyptCode);
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: AppConstants.egyptCode,
                            favorite: const ['+39', 'FR'],
                            // optional. Shows only country name and flag
                            showCountryOnly: true,
                            hideMainText: true,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                          )),
                      Expanded(
                        flex: 4,
                        child: StreamBuilder<String?>(
                          stream: _viewModel.outputErrorMobileNumber,
                          builder: (context, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _mobileNumberTextEditingController,
                              decoration: InputDecoration(
                                  hintText: AppStrings.mobileNumber.tr(),
                                  labelText: AppStrings.mobileNumber.tr(),
                                  errorText: (snapshot.data)),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),
                const SizedBox(
                  height: AppSize.s17,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.email.tr(),
                            labelText: AppStrings.email.tr(),
                            errorText: (snapshot.data)),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s17,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordTextEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.password.tr(),
                            labelText: AppStrings.password.tr(),
                            errorText: (snapshot.data)),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s17,
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child: Container(
                      height: AppSize.s40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s8),
                          border: Border.all(color: ColorManager.grey)),
                      child: GestureDetector(
                        child: _getMediaWidget(),
                        onTap: () {
                          _showPicker(context);
                        },
                      ),
                    )),
                const SizedBox(
                  height: AppSize.s17,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.register();
                                }
                              : null,
                          child: Text(AppStrings.register.tr()),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28,
                      right: AppPadding.p28,
                      top: AppPadding.p18),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
                    },
                    child: Text(
                      AppStrings.alreadyHaveAnAccount.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.arrow_forward),
              trailing: const Icon(Icons.camera),
              title: Text(AppStrings.photoGallery.tr()),
              onTap: () {
                _imageFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_forward),
              trailing: const Icon(Icons.camera_alt_outlined),
              title: Text(AppStrings.photoCamera.tr()),
              onTap: () {
                _imageFromCamera();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(AppStrings.profilePicture.tr())),
          Flexible(
            child: StreamBuilder<File>(
              stream: _viewModel.outputProfilePicture,
              builder: (context, snapshot) {
                return _imagePickedByUser(snapshot.data);
              },
            ),
          ),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCamera))
        ],
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
