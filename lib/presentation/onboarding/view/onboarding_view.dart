import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/constants_manager.dart';
import 'package:shop_app/presentation/resources/routes_manager.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
import 'package:shop_app/presentation/resources/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../domain/model/models.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final AppPreferences _appPreferences=instance<AppPreferences>();

  _bind() {
    _appPreferences.setOnBoardingViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return _getContentWidget(snapshot.data);
        }
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
          )),
      body: PageView.builder(
        itemCount: sliderViewObject!.numOfSlides,
        controller: _pageController,
        onPageChanged: (index) {
          _viewModel.onPageChanged(index);
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(sliderViewObject.sliderObject);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, Routes.loginRoute);
                },
                child: Text(
                  AppStrings.skip.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            _getBottomSheetWidget(sliderViewObject)
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget(SliderViewObject? sliderObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTimer),
                    curve: Curves.bounceIn);
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < sliderObject!.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderObject.currentIndex),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTimer),
                    curve: Curves.bounceIn);
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.hollowCirlceIc);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image)
      ],
    );
  }
}
