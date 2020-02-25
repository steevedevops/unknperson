import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/src/screen/configuracao.dart';
import 'package:unknperson/src/screen/home.dart';
import 'package:unknperson/src/screen/login.dart';
import 'package:unknperson/services/api.dart';
import 'package:unknperson/src/screen/privacidade-form.dart';
import 'package:unknperson/src/screen/userinformation-form.dart';
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
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 50.5, 0.0, 0.0),
                    child: Text("UNKNOW",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFfc5185),
                        )),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  InkWell(
                      onTap: () async {
                        bool result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserinformationsScreen()));
                          if (result == true) {
                          }
                      },
                      child: ListTile(
                        title: Text('${this.username}',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800)),
                        subtitle: Text('${this.email}',
                            maxLines: 1,
                            style: TextStyle(
                                color: Color(0xFFf0f0f0),
                                fontSize: 13,
                                fontWeight: FontWeight.w800)),
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFfc5185),
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      )),
                  Divider(
                    height: 50,
                    thickness: 0.5,
                    color: Colors.white.withOpacity(0.3),
                    endIndent: 20,
                    indent: 20,
                  ),
                  SidebarItem(Icons.home, "Home", () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  }),
                  SidebarItem(Icons.lock_outline, "Privacidade", () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacidadeScreen()));
                  }),
                  Divider(
                    height: 64,
                    thickness: 0.5,
                    color: Colors.white.withOpacity(0.3),
                    endIndent: 20,
                    indent: 20,
                  ),
                  SidebarItem(Icons.settings, "Configurações", () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfiguracaoScreen()));
                  }),
                  SidebarItem(Icons.exit_to_app, "Sair", () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      await prefs.setBool('statuslogin', false);
                      await prefs.setString('mobileclose', 'true');
                      await prefs.commit();
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));                  
                  }),
                ],
              ),
            )),
          ],
        ),
      )),
    );
  }
}
