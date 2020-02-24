import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/models/Fakeperson.dart';
import 'package:unknperson/models/FakepersonFields.dart';
import 'package:unknperson/models/Usuario.dart';
import 'package:http/http.dart' as http;

import '../models/FakepersonFields.dart';

class Services {
  static final url_api = 'http://70c03a0d.ngrok.io';

  static Future<Usuario> getlogin(Map data) async {
    var _usuario;
    var header = {'Content-Type': 'application/json'};
    var _body = json.encode(data);
    var response =
        await http.post(url_api + '/api/login/', headers: header, body: _body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

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
    } else {
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
    var response = await http.get(url_api + '/api/userfakeperson/?search=&limit=1000',
        headers: header);
    // final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');
    Map mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      prefs.setBool('statuslogin', true);
      for (Map res in mapResponse['fakePersons']) {
        print(res['pk']);
        await fakepersonList.add(Fakeperson.fromJson(res));
      }
    } else {
      prefs.setBool('statuslogin', false);
      prefs.setString('msg_login', mapResponse['msg']);
    }
    await prefs.commit();
    return fakepersonList;
  }

  static Future<bool> updateFakeperson(Fakeperson fakeperson) async {
    print(fakeperson.toJson());
    // return true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var header = {
      'Content-Type': 'application/json',
      'Cookie': 'sessionid=${prefs.getString('sessionid')}'
    };
    var _body = json.encode(fakeperson.toJson());

    var response = await http.put(url_api + '/api/userfakeperson/',
        headers: header, body: _body);

    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      Map mapResponse = json.decode(response.body);
      prefs.setBool('statuslogin', false);
      prefs.setString('msg_login', mapResponse['msg']);
      await prefs.commit();
      return false;
    } else {
      return false;
    }
  }

  static Future<FakepersonFields> getnewFakeperson() async {
    var _fakepersonfields;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var header = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url_api + '/api/?gender=M', headers: header);

    Map mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      mapResponse['fp_gender'] = mapResponse['person']['gender'];
      mapResponse['fp_image'] = mapResponse['person']['image'];
      mapResponse['fp_cpf'] = mapResponse['person']['cpf'];
      mapResponse['fp_fullName'] = mapResponse['person']['fullName'];
      mapResponse['fp_email'] = mapResponse['person']['email'];
      mapResponse['fp_age'] = mapResponse['person']['age'];
      mapResponse['fp_birthDate'] = mapResponse['person']['birthDate'];
      mapResponse['fp_latitude'] = '';
      mapResponse['fp_longitude'] = '';
      mapResponse['fp_description'] = '';

      _fakepersonfields = FakepersonFields.fromJson(mapResponse);
    } else if (response.statusCode == 403) {
      prefs.setBool('statuslogin', false);
      prefs.setString('msg_login', mapResponse['msg']);
      await prefs.commit();
    } else {
      return null;
    }
    return _fakepersonfields;
  }

  static Future<String> getnewCpf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var header = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url_api + '/api/cpf/', headers: header);

    print(response.statusCode);

    Map mapResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return mapResponse['cpf'];
    } else if (response.statusCode == 403) {
      prefs.setBool('statuslogin', false);
      prefs.setString('msg_login', mapResponse['msg']);
      await prefs.commit();
      return '';
    } else {
      return '';
    }
  }

  static Future<String> getnewName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var header = {
      'Content-Type': 'application/json',
    };
    var response =
        await http.get(url_api + '/api/fullName/?gender=M', headers: header);

    print(response.statusCode);

    Map mapResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return mapResponse['fullName'];
    } else if (response.statusCode == 403) {
      prefs.setBool('statuslogin', false);
      prefs.setString('msg_login', mapResponse['msg']);
      await prefs.commit();
      return '';
    } else {
      return '';
    }
  }

  static Future<String> getEmail(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var header = {
      'Content-Type': 'application/json',
    };
    var response =
        await http.get(url_api + '/api/email/?name=${name}', headers: header);

    print(response.statusCode);

    Map mapResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return mapResponse['email'];
    } else if (response.statusCode == 403) {
      prefs.setBool('statuslogin', false);
      prefs.setString('msg_login', mapResponse['msg']);
      await prefs.commit();
      return '';
    } else {
      return '';
    }
  }

  static Future<String> getRandomeimg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var header = {
      'Content-Type': 'application/json',
    };
    var response =
        await http.get(url_api + '/api/image/?gender=M', headers: header);

    print(response.statusCode);

    Map mapResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return mapResponse['image'];
    } else if (response.statusCode == 403) {
      prefs.setBool('statuslogin', false);
      prefs.setString('msg_login', mapResponse['msg']);
      await prefs.commit();
      return '';
    } else {
      return '';
    }
  }

  static Future<String> getdeleteperson(int pk) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var header = {
      'Content-Type': 'application/json',
      'Cookie': 'sessionid=${prefs.getString('sessionid')}'
    };
    var response = await http.delete(url_api + '/api/userfakeperson/?pk=${pk}',headers: header);
    print('Deletando registro do banco de dados ${response.statusCode}');
    Map mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      print(mapResponse.toString());
      return mapResponse['msg'];
    } else if (response.statusCode == 403) {
      prefs.setBool('statuslogin', false);
      prefs.setString('msg_login', mapResponse['msg']);
      await prefs.commit();
      return '';
    } else {
      return '';
    }

  }
}
