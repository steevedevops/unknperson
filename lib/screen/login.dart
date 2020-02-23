import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return SingleChildScrollView(
        child: new Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xff3E6FC1),
            ),
            child: Container(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Log in',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 42.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "WorkSansBold"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(23),
                    ),
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.height / 2.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(25.0, 30.0, 0.0, 10.0),
                          // decoration: BoxDecoration(color: Colors.red),
                          child: Text(
                            'User name',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3E6FC1),
                                fontFamily: "arial"),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Campo não pode estar vazío';
                              }
                              return null;
                            },
                            controller: username,
                            style: textStyle,
                            onChanged: (value) {
                              debugPrint('$value');
                              // vistoriaItemsdanos.vida_titulo = vidaTitulo.text;
                            },
                            decoration: InputDecoration(
                                // labelText: 'Chave',
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(25.0, 30.0, 0.0, 10.0),
                          // decoration: BoxDecoration(color: Colors.red),
                          child: Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3E6FC1),
                                fontFamily: "arial"),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Campo não pode estar vazío';
                              }
                              return null;
                            },
                            controller: password,
                            obscureText: true,
                            style: textStyle,
                            onChanged: (value) {
                              debugPrint('$value');
                              // vistoriaItemsdanos.vida_titulo = vidaTitulo.text;
                            },
                            decoration: InputDecoration(
                                // labelText: 'Chave',
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0)),
                        Container(
                            width: 250,
                            height: 80,
                            child: Center(
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                                onPressed: () async {},
                                color: Theme.of(context).primaryColor,
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Entrar",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              )),
            )));
  }
}
