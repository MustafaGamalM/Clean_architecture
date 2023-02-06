
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/presentation/resources/language.dart';

bool isEmailValid(String email){
  return RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

bool isRtl(BuildContext context){
  return context.locale == ARABIC_LOCAL;
}