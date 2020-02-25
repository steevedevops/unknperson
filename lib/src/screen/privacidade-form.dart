import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/services/api.dart';

class PrivacidadeScreen extends StatefulWidget {
  @override
  _PrivacidadeScreenState createState() => _PrivacidadeScreenState();
}

class _PrivacidadeScreenState extends State<PrivacidadeScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController currentpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  bool _loadState = false;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return ModalProgressHUD(
    
    child:
    
    Scaffold(
        key: _scaffoldKey,
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
                      obscureText: true,
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
                      obscureText: true,
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
        )
        )
        ), inAsyncCall: _loadState,
        );
  }

  Future<void> _updatePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {
		  "currentpassword": currentpassword.text,
		  "password": newpassword.text
	  };

    setState(() {
     _loadState = true;
    });

    var sucesse = await Services.changePassword(data);
  
    if (sucesse){
      _neverSatisfied(prefs.getString('msg_login'));
    }else{
      showInSnackBar(context, prefs.getString('msg_login'));
    }
     setState(() {
     _loadState = false;
    });
  }

  void showInSnackBar(BuildContext context, String value) {
    final snackBar = SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13.0, fontFamily: "WorkSansSemiBold"),
      ),
      duration: Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> _neverSatisfied(String msg) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sucesso!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('$msg'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              currentpassword.text = '';
              newpassword.text = '';
            },
          ),
        ],
      );
    },
  );
} 
}
