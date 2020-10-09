import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';

import 'dashboard.dart';

void main() {
  runApp(MaterialApp(home: SignUpScreen()));
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int i = 0;
  List<Widget> container;

  ScrollController _scroll;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scroll = new ScrollController();
    Future.delayed(Duration(seconds: 4)).then((value) => scrollTo());
  }

  void scrollTo() async {
    while (true) {
      await _scroll.animateTo(700,
          curve: Curves.easeInOutCubic, duration: Duration(milliseconds: 4000));
      await _scroll.animateTo(-500,
          curve: Curves.easeInOutCubic, duration: Duration(milliseconds: 4000));
    }
  }

  void scrollBack() {
    _scroll.animateTo(_scroll.offset - 100,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);
    double padding = device.size.width * (15 / 100);
    container = new List<Widget>();
    for (int i = 0; i < 14; i++) {
      container.add(ContainerWidget());
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scroll,
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(children: container),
                  Row(children: container),
                  Row(children: container),
                  Row(children: container),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xFFFF7399D7),
                    Color(0xFFFF3063CA)
                  ],
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: 30,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: (device.size.height) * 33 / 100),
                  Center(
                    child: Text(
                      "INFIGON",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Infinite Opportunities. One you.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: (device.size.height) * 20 / 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 45.0,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                                border: Border.all(color: Colors.white)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 55.0,
                                ),
                                Center(
                                  child: Text(
                                    "Sign Up with E-mail",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: padding,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            scrollTo();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 45.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                                border: Border.all(color: Colors.white)),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 55,
                                ),
                                Center(
                                  child: Text("Sign Up with Google"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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

class ContainerWidget extends StatelessWidget {
  final double width, height;
  const ContainerWidget({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text("widget"),
        ),
        width: width == null ? 100 : width,
        height: height == null ? 100 : height,
        decoration: BoxDecoration(
          color: Colors.teal[100],
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
