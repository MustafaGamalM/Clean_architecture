import 'dart:async';
import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_app/domain/model/models.dart';
import 'package:shop_app/domain/usecase/home_usecase.dart';
import 'package:shop_app/presentation/base/baseviewmodel.dart';

import '../../../common/state_renderer/state_renderer.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';
import '../../../resources/strings_manager.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _homeObjectStreamController =
      BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  @override
  void start() async{
    _getHomeData();
  }

  @override
  void dispose() {
    _homeObjectStreamController.close();
  }


  @override
  Sink get inputHomeObject => _homeObjectStreamController.sink;

  // outputs

  @override
  Stream<HomeViewObject> get outputHomeObject =>
      _homeObjectStreamController.stream.map((homeObj) => homeObj);



  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: AppStrings.loading.tr()));
    (await _homeUseCase.execute(Void)).fold(
        (failure) => {
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.message))
            }, (homeObject) async{
      // to dismiss any popup loading
      inputState.add(ContentState());
      //HomeObject(homeObject.data);
      inputHomeObject.add(HomeViewObject(homeObject.data.services,homeObject.data.banners,homeObject.data.stores));

    });
  }
}

abstract class HomeViewModelInput {
 Sink get inputHomeObject;
}

abstract class HomeViewModelOutput {
 Stream get outputHomeObject;
}

class HomeViewObject{
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;
  HomeViewObject(this.services,this.banners,this.stores);
}
