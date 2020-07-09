import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Contact Us"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Email"),
              subtitle: Text("example@exmplae.com"),
            ),
            ListTile(
              title: Text("Address"),
              subtitle: Text("example"),
            ),
            ListTile(
              title: Text("Photo"),
              subtitle: Text("9860145445"),
            ),
          ],
        ),
      ),
    );
  }
}
