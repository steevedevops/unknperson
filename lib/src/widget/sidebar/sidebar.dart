import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/src/screen/login.dart';
import 'package:unknperson/services/api.dart';
import 'package:unknperson/src/widget/sidebar/sidbar_items.dart';

class Sidebar extends StatelessWidget {
  String username;
  String email;
  Sidebar({this.username, this.email});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            SafeArea(
                child: Container(
                    child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 35.0, 10.0, 30.0),
                    child: Text("UNKN",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    child: ListTile(
                        title: Center(
                          heightFactor: 2.0,
                          child: Text('${this.username}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800)),
                        ),
                        subtitle: Center(
                          child: Text('${this.email}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800)),
                        )),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  SidebarItem(null, "Inicio", () {}),
                  Divider(
                    height: 30,
                    thickness: 0.5,
                    color: Colors.white.withOpacity(0.3),
                    endIndent: 20,
                    indent: 20,
                  ),
                  SidebarItem(null, "About", () {}),
                  Divider(
                    height: 30,
                    thickness: 0.5,
                    color: Colors.white.withOpacity(0.3),
                    endIndent: 20,
                    indent: 20,
                  ),
                  SidebarItem(null, "Sair", () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    try {
                      var usuario = await Services.getlogout();                                      
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      
                    } catch (e) {
                      print(e);
                    }
                                        
                  }),
                ],
              ),
            ))),
          ],
        ),
      )),
    );
  }
}
