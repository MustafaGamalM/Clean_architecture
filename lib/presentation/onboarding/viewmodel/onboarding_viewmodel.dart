import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:shop_app/presentation/base/baseviewmodel.dart';

import '../../../domain/model/models.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObj) => sliderViewObj);

  //private fun
  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObject> _getSliderData() {
    return [
      SliderObject(AppStrings.onBoardingTitle1.tr(), AppStrings.onBoardingSubTitle1.tr(),
          ImageAssets.onBoardingLogo1),
      SliderObject(AppStrings.onBoardingTitle2.tr(), AppStrings.onBoardingSubTitle2.tr(),
          ImageAssets.onBoardingLogo2),
      SliderObject(AppStrings.onBoardingTitle3.tr(), AppStrings.onBoardingSubTitle3.tr(),
          ImageAssets.onBoardingLogo3),
      SliderObject(AppStrings.onBoardingTitle4.tr(), AppStrings.onBoardingSubTitle4.tr(),
          ImageAssets.onBoardingLogo4),
    ];
  }
}

// orders from view
abstract class OnBoardingViewModelInputs {
  void onPageChanged(int index);

  int goNext();

  int goPrevious();
  // stream controller input
  Sink get inputSliderViewObject;
}

  // from view model to view
abstract class OnBoardingViewModelOutputs {
  // stream controller output
  Stream<SliderViewObject> get outputSliderViewObject;
}
