import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shop_app/app/di.dart';
import 'package:shop_app/presentation/resources/language.dart';

import 'app/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(supportedLocales: const [ARABIC_LOCAL,ENGLISH_LOCAL], path: AEETS_LOCALISATION_PATH, child:Phoenix(child:  MyApp())));
}
