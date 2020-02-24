import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/models/Fakeperson.dart';
import 'package:unknperson/models/Usuario.dart';
import 'package:http/http.dart' as http;

class Services {
  static final url_api = 'http://a5e953f8.ngrok.io';

  static Future<Usuario> getlogin(Map data) async {
    var _usuario;
    var header = {'Content-Type': 'application/json'};
    var _body = json.encode(data);
    var response = await http.post(url_api + '/api/login/', headers: header, body: _body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    
    print('========================${response.statusCode}');

    Map mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {

      print(mapResponse.toString());
      
      //Save data on persisten information
      prefs.setString('fullname', mapResponse['fullName']);
      prefs.setString('email', data['email']);
      prefs.setString('sessionid', mapResponse['sessionid']);
      prefs.setBool('statuslogin', true);

      _usuario = Usuario.fromJson(mapResponse);
    } else {

      prefs.setBool('statuslogin', false);
      prefs.setString('msg_login', mapResponse['msg']);     

      _usuario = Usuario.fromJson(mapResponse);
    }
    await prefs.commit();
    return _usuario;
  }


  static Future<Usuario> getlogout() async {
    var _usuario;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var header = {
      'Content-Type': 'application/json',
      'Set-Cookie': 'sessionid=${prefs.getString('sessionid')}' 
    };
    var response = await http.get(url_api + '/api/logout/', headers: header);
    prefs.clear();
    print(response.statusCode);
    Map mapResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      prefs.setBool('statuslogin', false);
      _usuario = Usuario.fromJson(mapResponse);
    }else{
      prefs.setBool('statuslogin', false);
      _usuario = Usuario.fromJson(mapResponse);
    }
    await prefs.commit();
    return _usuario;
  }

  static Future<List<Fakeperson>> getPersonFromapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Fakeperson> fakepersonList = List();
    var _fakeperson;
    var header = {
      'Content-Type': 'application/json',
      'Cookie': 'sessionid=${prefs.getString('sessionid')}' 
    };
    var response = await http.get(url_api + '/api/userfakeperson/?search=', headers: header);
    // final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');
    Map mapResponse = json.decode(response.body);
  
    if (response.statusCode == 200) {
      prefs.setBool('statuslogin', true);
      for (Map res in mapResponse['fakePersons']) {
        print(res['pk']);
        await fakepersonList.add(Fakeperson.fromJson(res));
      }
    }else{
      prefs.setBool('statuslogin', false);
      prefs.setString('msg_login', mapResponse['msg']);
    }
    await prefs.commit();
    return fakepersonList;
  }
}