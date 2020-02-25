import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/src/screen/privacidade-form.dart';
import 'package:unknperson/src/screen/userinformation-form.dart';

class ConfiguracaoScreen extends StatefulWidget {
  @override
  _ConfiguracaoScreenState createState() => _ConfiguracaoScreenState();
}

class _ConfiguracaoScreenState extends State<ConfiguracaoScreen> {
  String username;
  String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getuserinformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuracao'),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              Container(
                color: Color(0xFFf2f2f2),
                padding: EdgeInsets.all(34),
                child: ListTile(
                        title: Text('$username',
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w800)),
                        subtitle: Text('$email',
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
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
                      ),
              ),
              SizedBox(
                    height: 10,
                  ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Trocar dados do usuario",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {   
                   Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserinformationsScreen()));
                                         
                },
              ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Trocar senha do usuario",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {     
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacidadeScreen()));             
                },
              ),
              
            ],
          ),
        )
      ),
    );
  }
  void _getuserinformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.username = prefs.getString('fullname');
      this.email = prefs.getString('email');
    });
  }
}