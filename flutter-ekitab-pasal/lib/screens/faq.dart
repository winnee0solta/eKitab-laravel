import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    final Size screenSize = media.size;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("FAQs"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        width: screenSize.width,
        height: screenSize.height,
        child: new ListView(
          children: <Widget>[
            new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 30),
                              child: Column(
                                children: <Widget>[
                                  Text("Frequently Asked Questions",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Arial, Helvetica",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          letterSpacing: 1.5))
                                ],
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title:
                                          Text("1. What is this application?"),
                                      subtitle: Text(
                                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo, impedit!"),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    ListTile(
                                      title:
                                          Text("2. What is this application?"),
                                      subtitle: Text(
                                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo, impedit!"),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    ListTile(
                                      title:
                                          Text("3. What is this application?"),
                                      subtitle: Text(
                                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo, impedit!"),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    ListTile(
                                      title:
                                          Text("4. What is this application?"),
                                      subtitle: Text(
                                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo, impedit!"),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    ListTile(
                                      title:
                                          Text("5. What is this application?"),
                                      subtitle: Text(
                                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo, impedit!"),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
