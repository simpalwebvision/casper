import 'package:shared_preferences/shared_preferences.dart';

const loginAdminKey = "ADMIN_LOGIN_STATUS";
const loginStaffKey = "STAFF_LOGIN_STATUS";
const loginManufacturingUnitKey = "MANUFACTURING_UNIT_LOGIN_STATUS";
const loginTechnicianKey = "TECHNICIAN_LOGIN_STATUS";
const profileDataKey = "PROFILEDATAKEY";
const machineListKey = "MACHINELISTKEY";
const loginUserId = "LOGINUSERID";
const loginUserType = "LOGINUSERTYPE";

class LocalPreferences {
  Future setAdminLoginBool(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loginAdminKey, value);
  }

  Future<bool?> getAdminLoginBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginAdminKey);
  }

  // ------------------------------------------------------------------
  Future setManufacturingUnitLoginBool(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loginManufacturingUnitKey, value);
  }

  Future<bool?> getManufacturingUnitLoginBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginManufacturingUnitKey);
  }

  // ------------------------------------------------------------------
  Future setTechnicianLoginBool(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loginTechnicianKey, value);
  }

  Future<bool?> getTechnicianLoginBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginTechnicianKey);
  }

  // ------------------------------------------------------------------

  Future setUserid(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(loginUserId, val);
  }

  Future<String?> getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(loginUserId);
  }
  // ------------------------------------------------------------------

  Future setUserType(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(loginUserType, val);
  }

  Future<String?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(loginUserType);
  }

  // ----------------------------------------------------------------------

  Future setProfileData(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(profileDataKey, val);
  }

  Future<String?> getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(profileDataKey);
  }

  // ----------------------------------------------------------------------

  Future setMachineList(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(machineListKey, val);
  }

  Future<String?> getMachineList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(machineListKey);
  }

  // ----------------------------------------------------------------------
}
