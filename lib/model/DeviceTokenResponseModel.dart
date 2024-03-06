import 'dart:convert';
/// success : 1
/// message : "success."
/// device_tokens : [{"user_id":"110","device_token":"cczsgJYIS9WFPgszYWqqE1:APA91bE6stuS77YisshIbOqto3BW5UYub97kv5pl-7sQk_yVwTmgC-ynky2QY67P3MZBAFBEi749DHYYYs4L_laekyJr08GXTzXhsskXEVWmJzuXPvGRfPTw3ocH2rYuWn9a-Noc0E5h","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Siddharthsinh Vaghela"},{"user_id":"108","device_token":"eUy0Z71jTCmS951v2yYQJS:APA91bHKeMkvwHXa9tvOtFz9Gq5Kx3b7B72U_q1G-BaZuzj9Qxg9AFElnstNZ8hPM0wNY9TjX_HkjGMzHTJwqVksj_YVdu7sCyajNSjbUabDjmXukD6RUOVmjHu_a_Fbx5ectXH0P62_","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Ankit Patel"},{"user_id":"119","device_token":"deq9msDKyEG2mtN3f0OBX4:APA91bFpUURehQiN7IirxM8ScfUsBufpF_fU3GiNLJ-llAkb-DBJQKIU86iuZoNiyOScKAa1Wmyy_fgzcYgy2Mxme39UIk_BEOD_S8a1yPN4RpmzjIpB7FQ6SQ1AXJIxUYs2uoN3SjXX","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Chirag Rawal"},{"user_id":"124","device_token":"fcEOdcmcBUIPpDVBwB0OAO:APA91bF6gw861ieqsq42UCFpNfnYPfB7R75PS6E_A2u60dGQlwz2ro4A3b_vZEBQ3nsA6a9qfMEkJc-e7CERsvHJN59i2XzmldmOd5N9SC8YXYqaU61MJYV_dhKpFnkB1_-2Iig1W4G7","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Vimesh Soni"},{"user_id":"117","device_token":"cnIaDy7KckI7n0kVuVyp-r:APA91bE-xl77wVSE2yFJrHJhNOEvLAok-LRLEpw3MDKe-aL6uA3V9JOajs1TAXyrbBbdPlaHzONKbkRTqEc00GR8uD3NcDuX1dqcOKKvlh92PJd9s5e6u280-HXN6oBenC8EYZYNXwly","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Gaurav Gaulechha"},{"user_id":"126","device_token":"fzVEj5o1x0p6qZjgyYPZ-t:APA91bEVtDjl-LIJA1pXInij_-arX7N4lLQ1gqW37uE-dQCtUWLxxUm-8EI8m37clU3sZwWWaw6gjy78QNSYFa1b1LRNIk48iH8eQYJ3WRUEtC0x96IuPqpvZGPdQftUZYfo0ceam_so","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Ketan Patel"},{"user_id":"118","device_token":"cabVe2GsU0vAozC2JHNts0:APA91bGh8-EHFB5-ZPffrzOPO1ebP6QJI-DEeU9aDGO7hpAivWRQT16N2j0E9Y3GLzvT0Yhkh_2tuwcBd9akeY3kVjqmeNnC6WUU61vHkE50YiyEVeNzE-McXcEllz6BzPumlq8P9xhn","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Arjun Javia"},{"user_id":"120","device_token":"eA32XbsmykNBkVRk0obhub:APA91bGFpWl_83C9pu2x9P-CPCf3wkFT3Cfvk2jYXbfvFs1Ixx7WqhITpWqiF8E_aLAM7uXpXTyu3aLAtoqxSTtvl2qgCuckwISbHDkAF7_ya8RBJ4FYVxe4U9JzDwi7CrKK6tqUCSgD","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Meet Thakkar"},{"user_id":"136","device_token":"eQwPsQnQSGmf46bJXGNv9g:APA91bERPwoyrVlqcmJjYbjqxBgIjkUCJeFTcOyo886UllfzYTsHEjyPlTwqjZ8lmxtrENorqnqmRX2mvHbMkagp9kBmla4Ut7kAMZizptikf5I1R1DcLgGzdbkyuKnU-lquDAEV_zuk","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Nischay Radadiya"},{"user_id":"137","device_token":"c03xePECFki-n0KNz3A40e:APA91bHs7MJGWnglxbhD_66Uxr84-9uOeXmEsjE9u6-uNHtNoC1doXiwwTeHOZWsIXD_e7WAyt3tiZgdCkX0cmRKpYjZV5yLTNY3FystTtjdhyPnqvDMO9d47uRb7PM-KUMgN0gnWetw","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Mushab Jamadar"},{"user_id":"127","device_token":"fRfQuuHQRQePXaqSlPztw7:APA91bGSmLrl55ObkHWgI08MnnVp9m6g7L0aGgHPhWvlad6W6ORpbm0T7NTlxLRFHcVsMi5yP98g2i0HOD28v2Qqh-j16fI4du92RowYAr8a5XoJD6Z9ttc-Cd0x5Y8fyegFNKHi2qHZ","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Himanshu Savaliya"},{"user_id":"128","device_token":"fOlc8223Ta69dDrS8wZMV5:APA91bHInNO_TX3ER43ILOAXuIBIHAM6Y4KEUnULlA8a-dD_X7BwX6lcClYVE4VfgdqL0bSM10V9YplOX5_Uo9nIIVdhAI0EzUI1gaEPQAW-YnYHus7maRvw6E_H5r7FHZwBbbMkk1Cd","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Dhwani Bhagat"},{"user_id":"116","device_token":"dknMwdEJQS2SvGQRbmMRaL:APA91bHh6VCQfGUGQMSMNMLKkW_Qr0mLM_rU1546l4C-q26Va3uCQi0uxTqvzWSCuoW0a3IVkxqLlDDdIGNbXMJiqSU0KEYIprf-t8RKLqwlGPzAT_EBwNEUIES3FSQAEthhEWni7FdE","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Nixon Christian"},{"user_id":"125","device_token":"fL3VZz-Q6U4nk4NhHmxV3Q:APA91bHu6TZYHyrULlqhduW0EGl_IG_Ut-u4V4Ob9RosFi2orWqgsCtOLC7nbgykgftIgkauor_lVlZCRzcij0qLRqRBAAl3OOK3TTbEEeLD8Z9zXnCDKmdkWPX5-nSoyWBdCY-V1HJ-","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Vishal Gediya"},{"user_id":"181","device_token":"cZtSfVFz8ksQhTKu4IUzMV:APA91bE16k9rX1mI7qmseTTeopxddM-oN0LYQalPBRUYNc3Vfd7UIalYrFUNaP_5TLsB5ujr4avUrk0TXGg4KlWLTSh61XGpfTVeXAD9AfKLM6lMJyyqqo4DFpx4POgiPqPbdR4OQ8J1","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Deep Patel"},{"user_id":"182","device_token":"fQVaYb6WQl-5-6gr2C04mI:APA91bFodgdlQIflupTtsXKhaL6lQKpk4MP2MQxu0VeAnHeauBMeQR3Ow_mHGiOCrFVmW4hCcbU2YOw1kMMvnNOIn_qBJlSJ5qxib_6JHY3Brih8cSvaJB9eKUdnKEzis-7WGq1SHd_d","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Pansuriya Keval"},{"user_id":"107","device_token":"cLEgtTX6S7CTSFS7xvGozG:APA91bEmbV-KXWPuEy1RPDtLSkzpxOuyH3p-ggCqfDF953i_Zx0Mg0xs43NhLN9kY4z19ZqbeG3KpUJEJmW6l2p85Xs5G25fUHN1FJVPTGdz0RoxTjUYBb_UTJAwqH3iRFPTZYQfj8gh","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Vikas Oza"},{"user_id":"135","device_token":"dgAvZ2Ear0Dti_cK55S5Lh:APA91bGOdT8horh2womk3w7pj3XfleqJVEJs-sPdKj_emLLnZ92X9uf3KLdKlPrnAi3HLlkuSLhr7NKGUr6jyy7LY9CS_rFKygF-pXhhKRamH3lqNhBdJbQzVYcNBf0YmyWuyFmtRCMz","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Bhavin Ratanghayra"},{"user_id":"109","device_token":"f8YhpehSn0rtnYErQBcWh_:APA91bFb8K38J2CGR75UbPsLxjpEbC9EuH-dkiDzj1PKGdGORCJjyi38vmgRWZvIFa7qVfl0PXJXlgu1RC1MtvBOL1631QdoskKLoZZPL5iTLyRLTC7hrNm_GbUquU2PjbyppUc2UZMC","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Punit Parmar"},{"user_id":"113","device_token":"dac4KwZtTh-BWTCT-0rpnG:APA91bGTa-my3yFHEwwfB8cNYbAFLltIcsFfB4DioMGv8vb_21-fXer2BlGaMMRcbiJfiH0_Q27IilZIyYMyjpcsMgCbqZcMoJZ2PaPZDhG6VuMnC4DSEOJNG1u0vCQ5_0Zq57KSbuhr","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Jay Patel"},{"user_id":"105","device_token":"c4p-XUP510wMpid_F7u65g:APA91bEkvD8eKst2ok6qeB0-_pKRs8-r62BuN7ISPirfvlJuWPKyw7NvfMWjUMmh89jONiJobNCpGHNb9A4jz2ZjBF75ezRQmjX-GLhmUu2E9xtcpfysMfwyA6U8gdRJt2-Hb_pB2kmb","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Hrishi Patel"},{"user_id":"109","device_token":"cS2c1R3_Sh2CD5KbhfaNyX:APA91bGjv3-ANr1FADRLKTGwvTIqYVWWDvOdce34pfU9sjbXBhvktwIGm9JqxvRx9kEr8cKqUVJUx6XSVzlySCZzN0-un1ad6BAiAEQ2qmLHKskeeumM0cX1mkljANSVk2VVPgMsWqDu","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Punit Parmar"},{"user_id":"123","device_token":"cSnrysLU0UUBlO8sSURZWh:APA91bGxvv-tcrZRujaKkeVIJDSkGNbSBKfPxnmC6_kudJP95jJkDA-AaLc55c0vaTZCI2Nqw4wEDPm2lGDwEESqKt7I0Yq1CWlRUpiPXSSjCL4en_5D1JvlL1zWnQtLmmr7z06DQJ4h","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Parth Patel"},{"user_id":"135","device_token":"esjW4pd51EVzpQN_Yy6uKM:APA91bHDYqgCjQAXZ0zG5PDTX6oRKo6ZzVoNgAqsTeGj-rt6fJBAkKgt3l3ts6_XYkaEZafz_dxiSN45-3yqUbVt_63LOa7002Yg1JmV5ejj66YFf2EstB4SDaDpZrIKF21heaB3aVtI","device_type":"IOS","device_name":"iPhone 15 Pro Max (17.0.1)","is_force_logout":"0","name":"Mr. Bhavin Ratanghayra"},{"user_id":"106","device_token":"dwpWk9QjNESslgYPOI5tyu:APA91bGmbg_xeUfHZvosZT1wc2KBmYIccbcBSHYRHpY8vAqkOiodKlsV7zrLlaMScaVwN_BxthVmpYcx8uWS2cQuqo2_FgHGsBqDqL1GQZ9_auRTiPccUXxgXfTqWz9M1-EcFVGjBN-Z","device_type":"IOS","device_name":null,"is_force_logout":"0","name":"Mr. Mahek Mevada"},{"user_id":"157","device_token":"dEpqAaZ5Rq6QI8zRDcAVl-:APA91bFCvCbAXL2GGyTVm5557ZjKkQUYoT8UzJugaTEQPLhpufpjqI6d84UHajInl5oXxI047TW2SZ63lOfaEd1EG7WlSTNmGGDCvJdQ1_-eKBKNkMy74_Kb0tz99FVr2y2Zort2fZrN","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Swar Shah"},{"user_id":"157","device_token":"fBTF_K4bRaarE602Tl4zuK:APA91bHvNeMR4K8ghpKEuth3gXaoYq1S-n2hQ1bXnBQ6JEqE-O1qO3zBOKUz1mCbIGzo0UglDlujeu8jrfAJ3bnR2GdepQNvza2VwsAZCa9QFH2Q-C3PpJXRbpBAzgHLuynoOuS9egH3","device_type":"Android","device_name":null,"is_force_logout":"0","name":"Mr. Swar Shah"},{"user_id":"116","device_token":"dknMwdEJQS2SvGQRbmMRaL:APA91bFqyGR4etsn1EAI0qMvfdVRTlOOe8B11kIKW7R83q6YcZHWWGtMPMep95-Vlqzy65QRLLGPT6Pxl7mCHc2QwBSqzCmqTekc6oRGVa-peVCMk5zQoMlkwr6dbYVUBTuy7Q2IeMSL","device_type":"Android","device_name":"SM-S928B (14)","is_force_logout":"0","name":"Mr. Nixon Christian"},{"user_id":"182","device_token":"eutFH6hmQZSOWPmiYz4X2L:APA91bHRvJfm8_nB5sD_JLvn1AHqYDlKk2Cr8B4exrGgAT6YNBh55aZKZo-2qHa_tkFMsth-bqWCaq8iNsNJaPgYQTUHUpQ5bLuQayge8hmaIL-HT1e1bGONJd2279Ocqd0Gm09DmJoC","device_type":"Android","device_name":"AC2001 (12)","is_force_logout":"0","name":"Mr. Pansuriya Keval"},{"user_id":"106","device_token":"eOUvdZEWRASfLgIvmGT0hX:APA91bHP5bd9BncOSa5P4lx4KYbc-jgWE1qdjUYZPc2lLfdVgNwIOv9d-dKTBbMwyynTBynuW9kBCSArKLcEA2gsLteX4nhbajrndAOkCqoDSDlWoA9veEDutNaE0HleR6WgYClpc-mT","device_type":"Android","device_name":"SM-M115F (12)","is_force_logout":"0","name":"Mr. Mahek Mevada"},{"user_id":"96","device_token":"c-pFiiOqsUulq4bcZ38iLc:APA91bHoPkOwIi9xF6rMrEQzl-5prG_giZXYkoVs_hNSez7-S9KU98-mnwop6Fu9K7ZGdBaq5y087UmIP2dAd0dfrtTBuckuoOqs6kYOHlO6rgiBCq2_xJIUMlPJDQXI6zl7DVAFqH1R","device_type":"IOS","device_name":"iPhone (17.3.1)","is_force_logout":"0","name":"Mr. Raj Shukla"},{"user_id":"233","device_token":"fbVHp4WzTyG8T7TsJOgHGU:APA91bGxTvGRY7z03c8GE6pimnkGxqVXyhKyVA_dhrG5nwsmIivYWRonbSbTJMEPan7foGF3_GWG2hJ9_h82mmAaHc5HwGLIk75c5AaMbXP-RvbzC-lNDpe1yuqvVS_L6fdaTuQvMOxT","device_type":"Android","device_name":"SM-A146B (14)","is_force_logout":"0","name":"Mrs. Priya Khatri"},{"user_id":"96","device_token":"dJV_Fed_rERriyzXFWB92z:APA91bFX9bl32-_26iKucXPnJf2Ac1waVJMI1qu2x4DaDOjfZqPNSHcF0LclLnEpLD9XKEg6zVEIT_U6n3LLV1OSDx5myuFz0iBLLb-GGtCTB5Cl1dQ-H2oFhOli4e_ZrcJqN-ryhRdM","device_type":"IOS","device_name":"iPhone (17.3.1)","is_force_logout":"0","name":"Mr. Raj Shukla"}]

DeviceTokenResponseModel deviceTokenResponseModelFromJson(String str) => DeviceTokenResponseModel.fromJson(json.decode(str));
String deviceTokenResponseModelToJson(DeviceTokenResponseModel data) => json.encode(data.toJson());
class DeviceTokenResponseModel {
  DeviceTokenResponseModel({
      num? success, 
      String? message, 
      List<DeviceTokens>? deviceTokens,}){
    _success = success;
    _message = message;
    _deviceTokens = deviceTokens;
}

  DeviceTokenResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['device_tokens'] != null) {
      _deviceTokens = [];
      json['device_tokens'].forEach((v) {
        _deviceTokens?.add(DeviceTokens.fromJson(v));
      });
    }
  }
  num? _success;
  String? _message;
  List<DeviceTokens>? _deviceTokens;
DeviceTokenResponseModel copyWith({  num? success,
  String? message,
  List<DeviceTokens>? deviceTokens,
}) => DeviceTokenResponseModel(  success: success ?? _success,
  message: message ?? _message,
  deviceTokens: deviceTokens ?? _deviceTokens,
);
  num? get success => _success;
  String? get message => _message;
  List<DeviceTokens>? get deviceTokens => _deviceTokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_deviceTokens != null) {
      map['device_tokens'] = _deviceTokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// user_id : "110"
/// device_token : "cczsgJYIS9WFPgszYWqqE1:APA91bE6stuS77YisshIbOqto3BW5UYub97kv5pl-7sQk_yVwTmgC-ynky2QY67P3MZBAFBEi749DHYYYs4L_laekyJr08GXTzXhsskXEVWmJzuXPvGRfPTw3ocH2rYuWn9a-Noc0E5h"
/// device_type : "Android"
/// device_name : null
/// is_force_logout : "0"
/// name : "Mr. Siddharthsinh Vaghela"

DeviceTokens deviceTokensFromJson(String str) => DeviceTokens.fromJson(json.decode(str));
String deviceTokensToJson(DeviceTokens data) => json.encode(data.toJson());
class DeviceTokens {
  DeviceTokens({
      String? userId, 
      String? deviceToken, 
      String? deviceType, 
      dynamic deviceName, 
      String? isForceLogout, 
      String? name,}){
    _userId = userId;
    _deviceToken = deviceToken;
    _deviceType = deviceType;
    _deviceName = deviceName;
    _isForceLogout = isForceLogout;
    _name = name;
}

  DeviceTokens.fromJson(dynamic json) {
    _userId = json['user_id'];
    _deviceToken = json['device_token'];
    _deviceType = json['device_type'];
    _deviceName = json['device_name'];
    _isForceLogout = json['is_force_logout'];
    _name = json['name'];
  }
  String? _userId;
  String? _deviceToken;
  String? _deviceType;
  dynamic _deviceName;
  String? _isForceLogout;
  String? _name;
DeviceTokens copyWith({  String? userId,
  String? deviceToken,
  String? deviceType,
  dynamic deviceName,
  String? isForceLogout,
  String? name,
}) => DeviceTokens(  userId: userId ?? _userId,
  deviceToken: deviceToken ?? _deviceToken,
  deviceType: deviceType ?? _deviceType,
  deviceName: deviceName ?? _deviceName,
  isForceLogout: isForceLogout ?? _isForceLogout,
  name: name ?? _name,
);
  String? get userId => _userId;
  String? get deviceToken => _deviceToken;
  String? get deviceType => _deviceType;
  dynamic get deviceName => _deviceName;
  String? get isForceLogout => _isForceLogout;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['device_token'] = _deviceToken;
    map['device_type'] = _deviceType;
    map['device_name'] = _deviceName;
    map['is_force_logout'] = _isForceLogout;
    map['name'] = _name;
    return map;
  }

}