import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/constatnts.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';

abstract class FlowState{
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends FlowState{
   StateRendererType stateRendererType;
  String? message;
  LoadingState({required this.stateRendererType , this.message =AppStrings.loading});

  @override
  String getMessage() => message ?? AppStrings.loading.tr();

  @override
  StateRendererType getStateRendererType() => stateRendererType;

}

class ErrorState extends FlowState{
  StateRendererType stateRendererType;
  String message;
  ErrorState( this.stateRendererType , this.message );

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

}

class EmptyState extends FlowState{
  String message;
  EmptyState(this.message);

  @override
  String getMessage() =>message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;

}

class SuccessState extends FlowState{
  final String message;
  SuccessState(this.message);

  @override
  String getMessage() => message ;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccessState;

}


class ContentState extends FlowState{
  ContentState();

  @override
  String getMessage() =>Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;

}

extension FlowStateExtension on FlowState{
  Widget getScreenWidget(BuildContext context ,Function retryActionFunction,Widget contentScreenWidget){
    switch(runtimeType){
      case LoadingState : {
        if(getStateRendererType() == StateRendererType.popupLoadingState){
          showPopUp(context,getMessage(),getStateRendererType());
          return contentScreenWidget;
        }
        else{
          return StateRenderer(stateRendererType: getStateRendererType(), message: getMessage(),retryActionFunction: retryActionFunction);
        }
      }
      case ErrorState : {
        dismissDialog(context);
        if(getStateRendererType() == StateRendererType.popupErrorState){
          showPopUp(context,getMessage(),getStateRendererType());
          return contentScreenWidget;
        }
        else{
          return StateRenderer(stateRendererType: getStateRendererType(), message: getMessage(),retryActionFunction: retryActionFunction);
        }
      }
      case EmptyState : {
        return StateRenderer(retryActionFunction: (){},stateRendererType:getStateRendererType() ,message:getMessage() );
      } case ContentState : {
         dismissDialog(context);
      return contentScreenWidget;
    }
      case SuccessState : {
        dismissDialog(context);
        showPopUp(context,getMessage(),getStateRendererType(),title: AppStrings.success.tr());
        return contentScreenWidget;
      }
      default :
        {
          dismissDialog(context);
          return contentScreenWidget;
        }

    }
  }


showPopUp(BuildContext context,String message,StateRendererType stateRendererType ,
    {String title = Constants.empty}){
    WidgetsBinding.instance.addPostFrameCallback((_) {
       showDialog(context: context, builder: (context) =>
          StateRenderer(stateRendererType: stateRendererType, message: message,retryActionFunction: (){},title: title,),);
    });
}
_isCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context){
    if(_isCurrentDialogShowing(context) ){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }
}