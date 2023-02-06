import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shop_app/app/app_prefs.dart';
import 'package:shop_app/data/data_source/local_data_source.dart';
import 'package:shop_app/data/network/error_handler.dart';
import 'package:shop_app/presentation/base/baseviewmodel.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../resources/constants_manager.dart';
import '../../../resources/routes_manager.dart';

class SettingsViewModel extends BaseViewModel  {
 final AppPreferences _appPreferences;
 final LocalDataSource _localDataSource;
  SettingsViewModel(this._appPreferences,this._localDataSource);
  @override
  void start() {
    inputState.add(ContentState());
  }
  @override
  void dispose() {
    super.dispose();
  }
  changeLanguage(BuildContext context){
    _appPreferences.changeLanguage();
    Phoenix.rebirth(context);
  }
  inviteFriends(){
    Share.share(AppConstants.contactUsLink);
  }

  logout(BuildContext context){
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }

  contactUs()async{
    Uri uriUrl=Uri.parse(AppConstants.contactUsLink);
    try{
      inputState.add(ContentState());
       await launchUrl(uriUrl) ;
    }catch(error){
     inputState.add(ErrorState(StateRendererType.popupErrorState, ErrorHandler.handle(error).failure.message));
    }
  }

}

