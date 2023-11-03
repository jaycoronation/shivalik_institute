import 'dart:convert';
/// cities : [{"id":"952","name":"Rajkot","state_id":"12"},{"id":"953","name":"Lodhika","state_id":"12"},{"id":"954","name":"Kotda Sangani","state_id":"12"},{"id":"955","name":"Kotda Sanghani","state_id":"12"},{"id":"956","name":"Jasdan","state_id":"12"},{"id":"957","name":"Kotda Saangani","state_id":"12"},{"id":"958","name":"Sardhar","state_id":"12"},{"id":"959","name":"Kotda","state_id":"12"},{"id":"960","name":"Sayla","state_id":"12"},{"id":"961","name":"Gondal","state_id":"12"},{"id":"962","name":"Kalavad","state_id":"12"},{"id":"963","name":"Dhrol","state_id":"12"},{"id":"964","name":"Paddhari","state_id":"12"},{"id":"965","name":"Dhoraji","state_id":"12"},{"id":"966","name":"Jetpur","state_id":"12"},{"id":"967","name":"Jamkandorna","state_id":"12"},{"id":"968","name":"Upleta","state_id":"12"},{"id":"969","name":"Jamjodhpur","state_id":"12"},{"id":"970","name":"Manavadar","state_id":"12"},{"id":"971","name":"Kutiyana","state_id":"12"},{"id":"972","name":"Bhanvad","state_id":"12"},{"id":"973","name":"Jamnagar","state_id":"12"},{"id":"974","name":"Okhamandal","state_id":"12"},{"id":"975","name":"Porbandar","state_id":"12"},{"id":"976","name":"Ranavav","state_id":"12"},{"id":"977","name":"Junagadh","state_id":"12"},{"id":"978","name":"Porbaandar","state_id":"12"},{"id":"979","name":"Jodiya","state_id":"12"},{"id":"980","name":"Khambhalia","state_id":"12"},{"id":"981","name":"Jodia","state_id":"12"},{"id":"982","name":"Lalpur","state_id":"12"},{"id":"983","name":"Kahbhalia","state_id":"12"},{"id":"984","name":"Kalyanpur","state_id":"12"},{"id":"985","name":"Jamkalyanpur","state_id":"12"},{"id":"986","name":"Bhesan","state_id":"12"},{"id":"987","name":"Talala","state_id":"12"},{"id":"988","name":"Keshod","state_id":"12"},{"id":"989","name":"Vanthali(S)","state_id":"12"},{"id":"990","name":"Mangrol","state_id":"12"},{"id":"991","name":"Malia","state_id":"12"},{"id":"992","name":"Malia Hatina","state_id":"12"},{"id":"993","name":"Patan-Veraval","state_id":"12"},{"id":"994","name":"Mendarda","state_id":"12"},{"id":"995","name":"Sutrapada","state_id":"12"},{"id":"996","name":"Una","state_id":"12"},{"id":"997","name":"Vanthli","state_id":"12"},{"id":"998","name":"Kodinar","state_id":"12"},{"id":"999","name":"Amreli","state_id":"12"},{"id":"1000","name":"Jafrabad","state_id":"12"},{"id":"1001","name":"Wadhwancity","state_id":"12"},{"id":"1002","name":"Wadhwanicity","state_id":"12"},{"id":"1003","name":"Wadhwan","state_id":"12"},{"id":"1004","name":"Surendranagar","state_id":"12"},{"id":"1005","name":"Lakhtar","state_id":"12"},{"id":"1006","name":"Lkhtar","state_id":"12"},{"id":"1007","name":"Dhrangadhra","state_id":"12"},{"id":"1008","name":"Dhrangsadhra","state_id":"12"},{"id":"1009","name":"Dshrangadhra","state_id":"12"},{"id":"1010","name":"Halvad","state_id":"12"},{"id":"1011","name":"Navsari","state_id":"12"},{"id":"1012","name":"Limbdi","state_id":"12"},{"id":"1013","name":"Limndi","state_id":"12"},{"id":"1014","name":"Surendra Nagar","state_id":"12"},{"id":"1015","name":"Dhandhuka","state_id":"12"},{"id":"1016","name":"Limbdiq","state_id":"12"},{"id":"1017","name":"Muli","state_id":"12"},{"id":"1018","name":"Chotila","state_id":"12"},{"id":"1019","name":"Ahmedabad","state_id":"12"},{"id":"1020","name":"Wankaner","state_id":"12"},{"id":"1021","name":"Maliya Miyana","state_id":"12"},{"id":"1022","name":"Morvi","state_id":"12"},{"id":"1023","name":"Morbi","state_id":"12"},{"id":"1024","name":"Taankaraa","state_id":"12"},{"id":"1025","name":"Tankara","state_id":"12"},{"id":"1026","name":"Dahisara","state_id":"12"},{"id":"1027","name":"Malia(M)","state_id":"12"},{"id":"1028","name":"Maliya","state_id":"12"},{"id":"1029","name":"Bhavnagar","state_id":"12"},{"id":"1030","name":"Gogha","state_id":"12"},{"id":"1031","name":"Talaja","state_id":"12"},{"id":"1032","name":"Mahuva","state_id":"12"},{"id":"1033","name":"Sihor","state_id":"12"},{"id":"1034","name":"Damnagar","state_id":"12"},{"id":"1035","name":"Palitana","state_id":"12"},{"id":"1036","name":"Umrala","state_id":"12"},{"id":"1037","name":"Gariyadhar","state_id":"12"},{"id":"1038","name":"Patan","state_id":"12"},{"id":"1039","name":"Vallabhiopur","state_id":"12"},{"id":"1040","name":"Vallabhipur","state_id":"12"},{"id":"1041","name":"Vallbhiopur","state_id":"12"},{"id":"1042","name":"Vallbhipur","state_id":"12"},{"id":"1043","name":"Gadhada Sn","state_id":"12"},{"id":"1044","name":"Lathi","state_id":"12"},{"id":"1045","name":"Vadia","state_id":"12"},{"id":"1046","name":"Jesar","state_id":"12"},{"id":"1047","name":"Savar Kundla","state_id":"12"},{"id":"1048","name":"Savarkundla","state_id":"12"},{"id":"1049","name":"Rajula","state_id":"12"},{"id":"1050","name":"Chalala","state_id":"12"},{"id":"1051","name":"Botad","state_id":"12"},{"id":"1052","name":"Gadhada","state_id":"12"},{"id":"1053","name":"Babra","state_id":"12"},{"id":"1054","name":"Bagasara","state_id":"12"},{"id":"1055","name":"Visavadar","state_id":"12"},{"id":"1056","name":"Kunkvav-Vadia","state_id":"12"},{"id":"1057","name":"Bagsra","state_id":"12"},{"id":"1058","name":"Kunkavav Vadia","state_id":"12"},{"id":"1059","name":"Liliya","state_id":"12"},{"id":"1060","name":"Khambha","state_id":"12"},{"id":"1061","name":"Dhari","state_id":"12"},{"id":"1062","name":"Bhuj","state_id":"12"},{"id":"1063","name":"Nakhatrana","state_id":"12"},{"id":"1064","name":"Anjar","state_id":"12"},{"id":"1065","name":"Bhachau","state_id":"12"},{"id":"1066","name":"Abdasa","state_id":"12"},{"id":"1067","name":"Rahpar","state_id":"12"},{"id":"1068","name":"Rapar","state_id":"12"},{"id":"1069","name":"Gandhidham","state_id":"12"},{"id":"1070","name":"Mundra","state_id":"12"},{"id":"1071","name":"K. Mandvi","state_id":"12"},{"id":"1072","name":"Mandvi","state_id":"12"},{"id":"1073","name":"Mandavi","state_id":"12"},{"id":"1074","name":"Kachchh","state_id":"12"},{"id":"1075","name":"Lakhpat","state_id":"12"},{"id":"1076","name":"Lakhapat","state_id":"12"},{"id":"1077","name":"Kachch","state_id":"12"},{"id":"1078","name":"Ahmadabad City","state_id":"12"},{"id":"1079","name":"City Taluka","state_id":"12"},{"id":"1080","name":"Daskroi","state_id":"12"},{"id":"1081","name":"Sanand","state_id":"12"},{"id":"1082","name":"Gandhinagar","state_id":"12"},{"id":"1083","name":"Gandhi Nagar","state_id":"12"},{"id":"1084","name":"Sannad","state_id":"12"},{"id":"1085","name":"Viramgam","state_id":"12"},{"id":"1086","name":"Kadi","state_id":"12"},{"id":"1087","name":"Kalol","state_id":"12"},{"id":"1088","name":"Detroj Rampura","state_id":"12"},{"id":"1089","name":"Detroj- Rampura","state_id":"12"},{"id":"1090","name":"Detroj-Rampura","state_id":"12"},{"id":"1091","name":"Mandal","state_id":"12"},{"id":"1092","name":"Patdi","state_id":"12"},{"id":"1093","name":"Detrioj-Rampura","state_id":"12"},{"id":"1094","name":"Dascroi","state_id":"12"},{"id":"1095","name":"Bavla","state_id":"12"},{"id":"1096","name":"Dholka","state_id":"12"},{"id":"1097","name":"Ranpur","state_id":"12"},{"id":"1098","name":"Barwala","state_id":"12"},{"id":"1099","name":"Dehgam","state_id":"12"},{"id":"1100","name":"Dasroi","state_id":"12"},{"id":"1101","name":"Ahmedabad City","state_id":"12"},{"id":"1102","name":"Mahesana","state_id":"12"},{"id":"1103","name":"Boriavi","state_id":"12"},{"id":"1104","name":"Mansa","state_id":"12"},{"id":"1105","name":"Dasada","state_id":"12"},{"id":"1106","name":"Dasda","state_id":"12"},{"id":"1107","name":"Dasdaa","state_id":"12"},{"id":"1108","name":"Vijapur","state_id":"12"},{"id":"1109","name":"Satlasana","state_id":"12"},{"id":"1110","name":"Visnagar","state_id":"12"},{"id":"1111","name":"Himatnagar","state_id":"12"},{"id":"1112","name":"Himatnagar.","state_id":"12"},{"id":"1113","name":"Idar","state_id":"12"},{"id":"1114","name":"Himatanagar","state_id":"12"},{"id":"1115","name":"Prantij","state_id":"12"},{"id":"1116","name":"Talod","state_id":"12"},{"id":"1117","name":"Khedbrahma","state_id":"12"},{"id":"1118","name":"Vadali","state_id":"12"},{"id":"1119","name":"Bhiloda","state_id":"12"},{"id":"1120","name":"Vijaynagar","state_id":"12"},{"id":"1121","name":"Modasa","state_id":"12"},{"id":"1122","name":"Meghraj","state_id":"12"},{"id":"1123","name":"Bayad","state_id":"12"},{"id":"1124","name":"Dhansura","state_id":"12"},{"id":"1125","name":"Malpur","state_id":"12"},{"id":"1126","name":"Sabarkantha","state_id":"12"},{"id":"1127","name":"Vijaynagar.","state_id":"12"},{"id":"1128","name":"Becharaji","state_id":"12"},{"id":"1129","name":"Kheralu","state_id":"12"},{"id":"1130","name":"Unjha","state_id":"12"},{"id":"1131","name":"Sidhpur","state_id":"12"},{"id":"1132","name":"Vadnagar","state_id":"12"},{"id":"1133","name":"Chanasma","state_id":"12"},{"id":"1134","name":"Harij","state_id":"12"},{"id":"1135","name":"Sami","state_id":"12"},{"id":"1136","name":"Santalpur","state_id":"12"},{"id":"1137","name":"Dabhoi","state_id":"12"},{"id":"1138","name":"Satalasana","state_id":"12"},{"id":"1139","name":"Vadnabar","state_id":"12"},{"id":"1140","name":"Amirgadh","state_id":"12"},{"id":"1141","name":"Banaskantha","state_id":"12"},{"id":"1142","name":"Palanpur","state_id":"12"},{"id":"1143","name":"Vadgam","state_id":"12"},{"id":"1144","name":"Danta","state_id":"12"},{"id":"1145","name":"Shri Amirgadh","state_id":"12"},{"id":"1146","name":"Shriamirgadh","state_id":"12"},{"id":"1147","name":"Vadagam","state_id":"12"},{"id":"1148","name":"Dhanera","state_id":"12"},{"id":"1149","name":"Tharad","state_id":"12"},{"id":"1150","name":"Bhabhar","state_id":"12"},{"id":"1151","name":"Deodar","state_id":"12"},{"id":"1152","name":"Radhanpur","state_id":"12"},{"id":"1153","name":"Santalpurp","state_id":"12"},{"id":"1154","name":"Dantiwada","state_id":"12"},{"id":"1155","name":"Disa","state_id":"12"},{"id":"1156","name":"Deesa","state_id":"12"},{"id":"1157","name":"Kankraj","state_id":"12"},{"id":"1158","name":"Kankrej","state_id":"12"},{"id":"1159","name":"Vav","state_id":"12"},{"id":"1160","name":"Nadiad","state_id":"12"},{"id":"1161","name":"Naidiad","state_id":"12"},{"id":"1162","name":"Mahemdavad","state_id":"12"},{"id":"1163","name":"Mehmedabad","state_id":"12"},{"id":"1164","name":"Umreth","state_id":"12"},{"id":"1165","name":"Kheda","state_id":"12"},{"id":"1166","name":"Mahemdabad","state_id":"12"},{"id":"1167","name":"Sojitra","state_id":"12"},{"id":"1168","name":"Matar","state_id":"12"},{"id":"1169","name":"Mahudha","state_id":"12"},{"id":"1170","name":"Anand","state_id":"12"},{"id":"1171","name":"Kathlal","state_id":"12"},{"id":"1172","name":"Petlad","state_id":"12"},{"id":"1173","name":"Kapadwanj","state_id":"12"},{"id":"1174","name":"Tarapur","state_id":"12"},{"id":"1175","name":"Kapadvanj","state_id":"12"},{"id":"1176","name":"Borsad","state_id":"12"},{"id":"1177","name":"Perlad","state_id":"12"},{"id":"1178","name":"Khambhat","state_id":"12"},{"id":"1179","name":"Tarapura=","state_id":"12"},{"id":"1180","name":"Unreth","state_id":"12"},{"id":"1181","name":"Thasra","state_id":"12"},{"id":"1182","name":"Birpur","state_id":"12"},{"id":"1183","name":"Thsra","state_id":"12"},{"id":"1184","name":"Balasinor","state_id":"12"},{"id":"1185","name":"Virpur","state_id":"12"},{"id":"1186","name":"Lunawada","state_id":"12"},{"id":"1187","name":"Panchmahals","state_id":"12"},{"id":"1188","name":"Anklav","state_id":"12"},{"id":"1189","name":"Godhra","state_id":"12"},{"id":"1190","name":"Savli","state_id":"12"},{"id":"1191","name":"Godhara","state_id":"12"},{"id":"1192","name":"Shehera","state_id":"12"},{"id":"1193","name":"Santrampur","state_id":"12"},{"id":"1194","name":"Morwa (Hadaf)","state_id":"12"},{"id":"1195","name":"Morva Hadaf","state_id":"12"},{"id":"1196","name":"Devgadbaria","state_id":"12"},{"id":"1197","name":"Devgadh Baria","state_id":"12"},{"id":"1198","name":"Limkheda","state_id":"12"},{"id":"1199","name":"Dhanpur","state_id":"12"},{"id":"1200","name":"Dohad","state_id":"12"},{"id":"1201","name":"Dahod","state_id":"12"},{"id":"1202","name":"Garbada","state_id":"12"},{"id":"1203","name":"Panchamahals","state_id":"12"},{"id":"1204","name":"Jhalod","state_id":"12"},{"id":"1205","name":"Fatepura","state_id":"12"},{"id":"1206","name":"Jahlod","state_id":"12"},{"id":"1207","name":"Likheda","state_id":"12"},{"id":"1208","name":"Khanpur","state_id":"12"},{"id":"1209","name":"Kadana","state_id":"12"},{"id":"1210","name":"Santrampura","state_id":"12"},{"id":"1211","name":"Ghoghamba","state_id":"12"},{"id":"1212","name":"Ghoghmba","state_id":"12"},{"id":"1213","name":"Halol","state_id":"12"},{"id":"1214","name":"Holol","state_id":"12"},{"id":"1215","name":"Jambughoda","state_id":"12"},{"id":"1216","name":"Vadodara","state_id":"12"},{"id":"1217","name":"Sinor","state_id":"12"},{"id":"1218","name":"Narmada","state_id":"12"},{"id":"1219","name":"Tilakwada","state_id":"12"},{"id":"1220","name":"Naswadi","state_id":"12"},{"id":"1221","name":"Sankheda","state_id":"12"},{"id":"1222","name":"Bodeli","state_id":"12"},{"id":"1223","name":"Pavijetpur","state_id":"12"},{"id":"1224","name":"Nasvadi","state_id":"12"},{"id":"1225","name":"Chhotaudepur","state_id":"12"},{"id":"1226","name":"Pavijetpura","state_id":"12"},{"id":"1227","name":"Chhota Udepur","state_id":"12"},{"id":"1228","name":"Chhota-Udepur","state_id":"12"},{"id":"1229","name":"Ch.Udepur","state_id":"12"},{"id":"1230","name":"Kawant","state_id":"12"},{"id":"1231","name":"Karjan","state_id":"12"},{"id":"1232","name":"Padra","state_id":"12"},{"id":"1233","name":"Rajpipla","state_id":"12"},{"id":"1234","name":"Vaghodia","state_id":"12"},{"id":"1235","name":"Vaghoida","state_id":"12"},{"id":"1236","name":"Vaghodida","state_id":"12"},{"id":"1237","name":"Anklesvar","state_id":"12"},{"id":"1238","name":"Jambusar","state_id":"12"},{"id":"1239","name":"Nandod","state_id":"12"},{"id":"1240","name":"Bharuch","state_id":"12"},{"id":"1241","name":"Bahruch","state_id":"12"},{"id":"1242","name":"Amod","state_id":"12"},{"id":"1243","name":"Hansot","state_id":"12"},{"id":"1244","name":"Vagra","state_id":"12"},{"id":"1245","name":"Jhagadia","state_id":"12"},{"id":"1246","name":"Dediapada","state_id":"12"},{"id":"1247","name":"Jambsuar","state_id":"12"},{"id":"1248","name":"Ankleshwar","state_id":"12"},{"id":"1249","name":"Andada","state_id":"12"},{"id":"1250","name":"Sagbara","state_id":"12"},{"id":"1251","name":"Surat","state_id":"12"},{"id":"1252","name":"Rajpipala","state_id":"12"},{"id":"1253","name":"Valia","state_id":"12"},{"id":"1254","name":"Nadod","state_id":"12"},{"id":"1255","name":"Chorasi","state_id":"12"},{"id":"1256","name":"Chorayasi","state_id":"12"},{"id":"1257","name":"Olpad","state_id":"12"},{"id":"1258","name":"Sayan","state_id":"12"},{"id":"1259","name":"Kamrej","state_id":"12"},{"id":"1260","name":"Makrej","state_id":"12"},{"id":"1261","name":"Surat City","state_id":"12"},{"id":"1262","name":"Udhna","state_id":"12"},{"id":"1263","name":"Sachin","state_id":"12"},{"id":"1264","name":"Lajpore","state_id":"12"},{"id":"1265","name":"Valod","state_id":"12"},{"id":"1266","name":"Bardoli","state_id":"12"},{"id":"1267","name":"Choryasi","state_id":"12"},{"id":"1268","name":"Palsana","state_id":"12"},{"id":"1269","name":"Songadh","state_id":"12"},{"id":"1270","name":"Vyara","state_id":"12"},{"id":"1271","name":"Fort Songadh","state_id":"12"},{"id":"1272","name":"Nijhar","state_id":"12"},{"id":"1273","name":"Nizar","state_id":"12"},{"id":"1274","name":"Uchchhal","state_id":"12"},{"id":"1275","name":"Velachha","state_id":"12"},{"id":"1276","name":"Umarpada","state_id":"12"},{"id":"1277","name":"Vankal","state_id":"12"},{"id":"1278","name":"Zankhvav","state_id":"12"},{"id":"1279","name":"Variav","state_id":"12"},{"id":"1280","name":"Ahwa","state_id":"12"},{"id":"1281","name":"Dang","state_id":"12"},{"id":"1282","name":"Dangs","state_id":"12"},{"id":"1283","name":"The Dangs","state_id":"12"},{"id":"1284","name":"Valsad","state_id":"12"},{"id":"1285","name":"Dharampur","state_id":"12"},{"id":"1286","name":"Hanuman Bhagda","state_id":"12"},{"id":"1287","name":"Chikhli","state_id":"12"},{"id":"1288","name":"Bansda","state_id":"12"},{"id":"1289","name":"Vansda","state_id":"12"},{"id":"1290","name":"Kaprada","state_id":"12"},{"id":"1291","name":"Umargam","state_id":"12"},{"id":"1292","name":"Umbergaon","state_id":"12"},{"id":"1293","name":"Gandevi","state_id":"12"},{"id":"1294","name":"Pardi","state_id":"12"},{"id":"1295","name":"Umargarm","state_id":"12"},{"id":"1296","name":"Dadra & Nagar Haveli","state_id":"12"},{"id":"1297","name":"Dungri","state_id":"12"},{"id":"1298","name":"Jalalpore","state_id":"12"},{"id":"1299","name":"Jalalporre","state_id":"12"}]
/// success : "1"
/// message : "Cities found"

CityResponseModel cityResponseModelFromJson(String str) => CityResponseModel.fromJson(json.decode(str));
String cityResponseModelToJson(CityResponseModel data) => json.encode(data.toJson());
class CityResponseModel {
  CityResponseModel({
      List<Cities>? cities, 
      String? success, 
      String? message,}){
    _cities = cities;
    _success = success;
    _message = message;
}

  CityResponseModel.fromJson(dynamic json) {
    if (json['cities'] != null) {
      _cities = [];
      json['cities'].forEach((v) {
        _cities?.add(Cities.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Cities>? _cities;
  String? _success;
  String? _message;
CityResponseModel copyWith({  List<Cities>? cities,
  String? success,
  String? message,
}) => CityResponseModel(  cities: cities ?? _cities,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Cities>? get cities => _cities;
  String? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cities != null) {
      map['cities'] = _cities?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// id : "952"
/// name : "Rajkot"
/// state_id : "12"

Cities citiesFromJson(String str) => Cities.fromJson(json.decode(str));
String citiesToJson(Cities data) => json.encode(data.toJson());
class Cities {
  Cities({
      String? id, 
      String? name, 
      String? stateId,}){
    _id = id;
    _name = name;
    _stateId = stateId;
}

  Cities.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _stateId = json['state_id'];
  }
  String? _id;
  String? _name;
  String? _stateId;
Cities copyWith({  String? id,
  String? name,
  String? stateId,
}) => Cities(  id: id ?? _id,
  name: name ?? _name,
  stateId: stateId ?? _stateId,
);
  String? get id => _id;
  String? get name => _name;
  String? get stateId => _stateId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['state_id'] = _stateId;
    return map;
  }

}