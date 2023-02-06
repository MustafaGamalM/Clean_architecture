import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/data/responses/responses.dart';
import 'package:shop_app/presentation/resources/language.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDONG_VIEWED = "PREFS_KEY_ONBOARDONG_VIEWED";
const String PREFS_KEY_LOGGEDIN = "PREFS_KEY_LOGGEDIN";

const String PREFS_KEY_HOME_DATA = "PREFS_KEY_HOME_DATA";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getPrefsLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> changeLanguage() async {
    String currentLanguage = await getPrefsLanguage();
    if (currentLanguage == LanguageType.ARABIC.getValue()) {
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
    } else {
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getPrefsLanguage();
    if (currentLanguage == LanguageType.ARABIC.getValue()) {
      return ARABIC_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }

  Future<void> setOnBoardingViewed() async {
    await _sharedPreferences.setBool(PREFS_KEY_ONBOARDONG_VIEWED, true);
  }

  Future<void> setLoggedIn() async {
    await _sharedPreferences.setBool(PREFS_KEY_LOGGEDIN, true);
  }

  Future<bool> getLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_LOGGEDIN) ?? false;
  }

  Future<bool> getOnBoardingViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDONG_VIEWED) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_LOGGEDIN);
  }

  // save home data

  Future<void> saveHomeDataToCache(HomeResponse homeResponse) async {
    await _sharedPreferences.setString(
        PREFS_KEY_HOME_DATA, json.encode(homeResponse.toJson()));
  }

  Future<HomeResponse> getHomeDataFromCache() async {
    var res = await _sharedPreferences.getString(PREFS_KEY_HOME_DATA);
    return HomeResponse.fromJson(json.decode(res!));
  }
}
