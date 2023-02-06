import 'dart:async';
import 'dart:ffi';

import 'package:rxdart/rxdart.dart';
import 'package:shop_app/domain/usecase/store_details_usecase.dart';
import 'package:shop_app/presentation/base/baseviewmodel.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../domain/model/models.dart';

class StoreDetailsViewModel extends BaseViewModel with StoreDetailsObjectInput,StoreDetailsObjectOutput{

 final StoreDetailsUseCase _storeDetailsUseCase;
final StreamController _storeDetailsStreamController=BehaviorSubject<StoreDetails>();
  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  void start() async{
    _getStoreDetails();
  }
  @override
  void dispose() {
    _storeDetailsStreamController.close();
  }

  //inputs

 @override
 Sink get inputStoreDetailsObject => _storeDetailsStreamController.sink;

  _getStoreDetails()async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState ));
    (await _storeDetailsUseCase.execute(Void)).fold((error) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, error.message));
    }, (detailsObj)async {
      inputState.add(ContentState());
      inputStoreDetailsObject.add(detailsObj);
    });
  }

// outputs

  @override
  Stream<StoreDetails> get outputStoreDetailsObject => _storeDetailsStreamController.stream.map((storeObj) => storeObj);
}

abstract class StoreDetailsObjectInput {
  Sink get inputStoreDetailsObject;
}

abstract class StoreDetailsObjectOutput {
  Stream<StoreDetails> get outputStoreDetailsObject;
}


