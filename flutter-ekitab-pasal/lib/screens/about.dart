import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _lorem = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Laboriosam et ipsam maxime facilis. Modi et labore ullam aspernatur facilis molestiae impedit accusantium at consequatur explicabo minima dignissimos quis, dolore non dicta eum quaerat quos iste? Totam corporis libero, est qui vel aut ad obcaecati perspiciatis doloremque quibusdam, mollitia dolor itaque unde facilis. Inventore molestiae perferendis ut tempore? Iusto beatae veniam nam iure, labore alias et necessitatibus! Pariatur ipsa unde facere sunt voluptatibus odio voluptatem sit esse qui debitis enim asperiores tempore, amet consequatur aliquid veniam! Rerum provident in, repellat veniam dolor fugit, esse quisquam optio distinctio, quaerat ipsum ullam alias!";
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("About Us"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Card(child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: new Text(_lorem),
          )),
        ),
      ),
    );
  }
}