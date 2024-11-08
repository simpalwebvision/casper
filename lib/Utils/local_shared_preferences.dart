import 'package:shared_preferences/shared_preferences.dart';

const loginUserKey = "USER_LOGIN_STATUS";
const loginPartnerKey = "PARTNER_LOGIN_STATUS";
const custAuthKey = "CUSTAUTHKEY";
const techIdKey = "TECHIDKEY";
const profileDataKey = "PROFILEDATAKEY";

class LocalPreferences {
  Future setLoginBool(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loginUserKey, value);
  }

  Future<bool?> getLoginBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginUserKey);
  }

  // ------------------------------------------------------------------

  Future setProfileData(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(profileDataKey, val);
  }

  Future<String?> getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(profileDataKey);
  }

  // ----------------------------------------------------------------------
}
