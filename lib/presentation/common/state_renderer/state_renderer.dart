import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/font_manager.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
import 'package:shop_app/presentation/resources/styles_manager.dart';
import 'package:shop_app/presentation/resources/values_manager.dart';

enum StateRendererType{
  popupLoadingState,
  popupErrorState,
  popupSuccessState,

  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  // general (popup & full screen)

  contentState
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;
   StateRenderer({required this.stateRendererType,this.message="",this.title="",required this.retryActionFunction}) ;

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }
  Widget _getStateWidget(BuildContext context){
    switch(stateRendererType){
      case StateRendererType.contentState:
        return Container();
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([_getAnimatedJson(JsonAssets.error),_getText(message),_getRetryButton(AppStrings.retryAgain.tr(),context)]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([_getAnimatedJson(JsonAssets.loading),_getText(message)]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn([_getAnimatedJson(JsonAssets.empty),_getText(message)]);
      case StateRendererType.popupErrorState:
        return _getPopUpDialog(context,[_getAnimatedJson(JsonAssets.error),_getText(message),_getRetryButton(AppStrings.ok.tr(),context)]);
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog(context,[_getAnimatedJson(JsonAssets.loading)]);
      case StateRendererType.popupSuccessState :
        return _getPopUpDialog(context,[_getAnimatedJson(JsonAssets.success),_getText(message) , _getText(title), _getRetryButton(AppStrings.ok.tr(),context)]);
      default :
          return Container();
    }
  }
  Widget _getItemsColumn(List<Widget> children)
  {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
  }
  
  Widget _getAnimatedJson(String jsonName){
    return SizedBox(height: AppSize.s100,width: AppSize.s100,
    child: Lottie.asset(jsonName),
    );
  }
  Widget _getText(String message){
    return Center(
      child: Padding(
        padding:const  EdgeInsets.all(AppPadding.p10),
        child: Text(message,style: getRegularText(color: ColorManager.black,fontSize: FontSize.s16),),
      ),
    );
  }
  
  Widget _getRetryButton(String buttonTitle,BuildContext context){
    return Padding(
      padding:const EdgeInsets.all(AppPadding.p16),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: (){
            if(stateRendererType==StateRendererType.fullScreenErrorState)
              {
                 retryActionFunction.call();
              }else{
              Navigator.of(context).pop();
            }
          }, child: Text(buttonTitle))),
    );
  }

  Widget _getPopUpDialog(BuildContext context,List<Widget> children){
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s14),),
      backgroundColor: Colors.transparent,
      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s14),
            shape: BoxShape.rectangle,
            color: ColorManager.white ,boxShadow:const [BoxShadow(color: Colors.black26,)]),child: _getDialogContent(context,children),),
    );
  }
  Widget _getDialogContent(BuildContext context,List<Widget> children){
      return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
