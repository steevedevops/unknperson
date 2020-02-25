import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/services/api.dart';

class UserinformationsScreen extends StatefulWidget {
  @override
  _UserinformationsScreenState createState() => _UserinformationsScreenState();
}

class _UserinformationsScreenState extends State<UserinformationsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(title: Text('Trocar dados do usuario')),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
             if (_formKey.currentState.validate()) {
               _updateUserinformations();
             }
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.save),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0.0,
                          (MediaQuery.of(context).size.height / (4.6)),
                          0.0,
                          0.0)),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / (1.2)),
                    child: TextFormField(
                      onChanged: (value) {
                        
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'campo nao pode estar vazio';
                        }
                        return null;
                      },
                      controller: firstname,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: 'First name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / (1.2)),
                    child: TextFormField(
                      onChanged: (value) {},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'campo nao pode estar vazio';
                        }
                        return null;
                      },
                      controller: lastname,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: 'Last name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / (1.2)),
                    child: TextFormField(
                      onChanged: (value) {},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'campo nao pode estar vazio';
                        }
                        return null;
                      },
                      controller: username,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: 'User name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ))),
        )));
  }

  Future<void> _updateUserinformations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {		
     "first_name": firstname.text,
	  	"last_name": lastname.text,
		  "username": username.text
	  };

    var sucesse = await Services.changeUserinformation(data);
    
    if (sucesse){
      Navigator.pop(context);
    }
    debugPrint('dados para funcionaso ${prefs.getString('msg_login')}');
  }
}
