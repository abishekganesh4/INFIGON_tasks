import 'package:flutter/material.dart';

import '../main.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    Key key,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Text(
            "For You",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        listViewContainer(),
        lineContainer(),
        listViewContainer(),
        lineContainer(),
        listViewContainer(),
        lineContainer(),
        listViewContainer(),
        lineContainer(),
        listViewContainer(),
        lineContainer(),
      ],
    );
  }

  Opacity lineContainer() {
    return Opacity(
      opacity: 0.2,
      child:
          Container(height: 1, width: screenWidth * 0.6, color: Colors.black),
    );
  }

  Container listViewContainer() {
    return Container(
      child: Row(
        children: <Widget>[
          ContainerWidget(
            height: 90,
            width: 140,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dummy",
                style: TextStyle(fontSize: 20.0),
              ),
              Text("abcd", style: TextStyle(fontSize: 20.0)),
              Text(
                "2 min read | 9 oct",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
