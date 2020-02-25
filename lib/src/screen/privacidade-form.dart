import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/services/api.dart';

class PrivacidadeScreen extends StatefulWidget {
  @override
  _PrivacidadeScreenState createState() => _PrivacidadeScreenState();
}

class _PrivacidadeScreenState extends State<PrivacidadeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController currentpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(title: Text('Trocar senha')),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
             if (_formKey.currentState.validate()) {
               _updatePassword();
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
                          (MediaQuery.of(context).size.height / (3.9)),
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
                      controller: currentpassword,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: 'Current Password',
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
                      controller: newpassword,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: 'New password',
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

  Future<void> _updatePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {
		  "currentpassword": currentpassword.text,
		  "password": newpassword.text
	  };

    var sucesse = await Services.changePassword(data);
    

    if (sucesse){
      Navigator.pop(context);
    }
    debugPrint('dados para funcionaso ${prefs.getString('msg_login')}');
  }
}
