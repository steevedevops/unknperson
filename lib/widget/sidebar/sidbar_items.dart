import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  SidebarItem(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10, 30.0, 0),
      child: InkWell(
          splashColor: Colors.blueAccent,
          onTap: onTap,
          child: Container(
            color: Theme.of(context).primaryColor,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon, color: Colors.orange),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(text,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                // Icon(Icons.arrow_right),
              ],
            ),
          )),
    );
  }
}
