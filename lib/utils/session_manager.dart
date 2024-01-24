
import 'session_manager_methods.dart';

class SessionManager {
  /*
  "user_id": "18",
  "name": "Jay Mistry",
  "email": "jay.m@coronation.in",
  "phone": "7433036724",
  "dob": "04 Jun 2018",
  "referral_code": "YQB427",
  "has_login_pin": true,
  "image": "https://apis.roboadviso.com/assets/uploads/profiles/profile_1626788768_98.jpg"
*/
  final String isLoggedIn = "isLoggedIn";
  final String userId = "id";
  final String firstName = "first_name";
  final String lastName = "last_name";
  final String userType = "user_type";
  final String accessToken = "access_token";
  final String deviceToken = "deviceToken";
  final String feedbackClassId = "feedbackClassId";
  final String profilePic = "profilePic";


  //set data into shared preferences...
  Future createLoginSession(String apiUserId,String apiFirstName ,String apiLastName, String apiuserType,  String apiaccessToken,String apiProfilePic)
      async {
    await SessionManagerMethods.setBool(isLoggedIn, true);
    await SessionManagerMethods.setString(userId,apiUserId);
    await SessionManagerMethods.setString(firstName,apiFirstName);
    await SessionManagerMethods.setString(lastName,apiLastName);
    await SessionManagerMethods.setString(userType,apiuserType);
    await SessionManagerMethods.setString(accessToken,apiaccessToken);
    await SessionManagerMethods.setString(profilePic,apiProfilePic);
  }

  bool? checkIsLoggedIn() {
    return SessionManagerMethods.getBool(isLoggedIn);
  }

  String? getUserId() {
    return SessionManagerMethods.getString(userId);
  }

  Future<void> setUserId(String apiUserId)
  async {
    await SessionManagerMethods.setString(userId, apiUserId);
  }

  String? getProfilePic() {
    return SessionManagerMethods.getString(profilePic);
  }

  Future<void> setProfilePic(String apiProfilePic)
  async {
    await SessionManagerMethods.setString(profilePic, apiProfilePic);
  }

  String? getClassId() {
    return SessionManagerMethods.getString(feedbackClassId);
  }

  Future<void> setClassId(String apiClassId)
  async {
    await SessionManagerMethods.setString(feedbackClassId, apiClassId);
  }

  Future<void> setName(String apiFirstName)
  async {
    await SessionManagerMethods.setString(firstName, apiFirstName);
  }

  String? getName() {
    return SessionManagerMethods.getString(firstName);
  }

  Future<void> setDeviceToken(String apiDeviceToken)
  async {
    await SessionManagerMethods.setString(deviceToken, apiDeviceToken);
  }

  String? getDeviceToken() {
    return SessionManagerMethods.getString(deviceToken);
  }

  Future<void> setLastName(String apiLastName)
  async {
    await SessionManagerMethods.setString(lastName, apiLastName);
  }

  String? getLastName() {
    return SessionManagerMethods.getString(lastName);
  }

  Future<void> setuserType(String apiuserType)
  async {
    await SessionManagerMethods.setString(userType, apiuserType);
  }

  String? getuserType() {
    return SessionManagerMethods.getString(userType);
  }

  Future<void> setaccessToken(String apiaccessToken)
  async {
    await SessionManagerMethods.setString(accessToken, apiaccessToken);
  }

  String? getaccessToken() {
    return SessionManagerMethods.getString(accessToken);
  }

}