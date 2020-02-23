import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/models/Usuario.dart';
import 'package:http/http.dart' as http;

class Services {
  static final url_api = 'http://cd3ff502.ngrok.io';


  static Future<Usuario> getlogin(Map data) async {
    var _usuario;
    var header = {'Content-Type': 'application/json'};
    var _body = json.encode(data);
    var response = await http.post(url_api + '/api/login/', headers: header, body: _body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    
    print(response.statusCode);
    if (response.statusCode == 200) {

      Map mapResponse = json.decode(response.body);
      print(mapResponse.toString());
      //Save data on persisten information
      prefs.setString('fullname', mapResponse['fullName']);
      prefs.setString('email', data['email']);
      prefs.setString('sessionid', mapResponse['sessionid']);
      await prefs.commit();

      mapResponse['logado'] = true;
      _usuario = Usuario.fromJson(mapResponse);
    } else {

      Map mapResponse = json.decode(response.body);

      mapResponse['logado'] = false;
      mapResponse['msg_login'] = mapResponse['msg'];
     
      _usuario = Usuario.fromJson(mapResponse);
    }
    return _usuario;
  }
}