import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shop_app/app/app_prefs.dart';
import 'package:shop_app/data/data_source/local_data_source.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:shop_app/presentation/main/pages/settings/settings_viewmodel.dart';
import 'package:shop_app/presentation/resources/values_manager.dart';

import '../../../../app/di.dart';
import '../../../../app/functions.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';

import 'dart:math' as math;
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsViewModel _viewModel = instance<SettingsViewModel>();

  _bind(){
    _viewModel.start();
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
         return  snapshot.data?.getScreenWidget(context, () {
           _viewModel.contactUs();
          }, _getContentWidget()) ??
              _getContentWidget();
        },);
  }

  Widget _getContentWidget(){
   return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            onTap: (){
              _viewModel.changeLanguage(context);
            },
            leading:SvgPicture.asset(ImageAssets.changeLangIc) ,
            trailing:Transform(transform:Matrix4.rotationY( isRtl(context)?math.pi:0),alignment: Alignment.center ,child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),) ,
            title: Text(AppStrings.changeLanguage.tr(),style: Theme.of(context).textTheme.bodyLarge,),
          ),
          ListTile(
            onTap: (){
              _viewModel.contactUs();
            },
            leading:SvgPicture.asset(ImageAssets.contactUsIc) ,
            trailing:Transform(transform:Matrix4.rotationY( isRtl(context)?math.pi:0),alignment: Alignment.center ,child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),),
            title: Text(AppStrings.contactUs.tr(),style: Theme.of(context).textTheme.bodyLarge),
          ),
          ListTile(
            onTap: (){
              _viewModel.inviteFriends();
            },
            leading:SvgPicture.asset(ImageAssets.inviteFriendsIc) ,
            trailing:Transform(transform:Matrix4.rotationY( isRtl(context)?math.pi:0),alignment: Alignment.center ,child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),) ,
            title: Text(AppStrings.inviteYourFriends.tr(),style: Theme.of(context).textTheme.bodyLarge),
          ),
          ListTile(
            onTap: (){
              _viewModel.logout(context);
            },
            leading:SvgPicture.asset(ImageAssets.logoutIc) ,
            trailing:Transform(transform:Matrix4.rotationY( isRtl(context)?math.pi:0),alignment: Alignment.center ,child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),) ,
            title: Text(AppStrings.logout.tr(),style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
