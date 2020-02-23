import 'package:flutter/material.dart';

Widget loadState(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 256.0),
    padding: EdgeInsets.all(6.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35.0),
        color: Theme.of(context).primaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            offset: Offset(1.0, 1.0),
            blurRadius: 5.0,
          ),
        ]),
    child: Container(
        height: 42.0,
        width: 42.0,
        //color: Colors.white,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(7.0),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        )),
  );
}

Widget cardloadState(BuildContext context) {
  var body = new Column(
    children: <Widget>[
      new Container(
        height: 40.0,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.fromLTRB(15.0, 150.0, 15.0, 0.0),
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: new TextField(
          decoration: new InputDecoration.collapsed(hintText: "username"),
        ),
      ),
      new Container(
        height: 40.0,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(15.0),
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: new TextField(
          decoration: new InputDecoration.collapsed(hintText: "password"),
        ),
      ),
    ],
  );

  return new Container(
    child: new Stack(
      children: <Widget>[
        body,
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white70,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.blue[200],
                borderRadius: new BorderRadius.circular(10.0)),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "loading.. wait...",
                      style: new TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget loadModal(BuildContext context) {
  return new Container(
      color: Colors.grey[300],
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    );
}