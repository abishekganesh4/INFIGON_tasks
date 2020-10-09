import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:ui_task/main.dart';
import 'package:ui_task/widget/listView_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 500);
  final Duration navDuration = const Duration(milliseconds: 800);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<FadeInImage> _fadeAnimation;
  int highlightNavBarFlag = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(_controller);
    _fadeAnimation = Tween<FadeInImage>().animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);
    screenWidth = device.size.width;
    screenHeight = device.size.height;
    List<AssetImage> list = [
      AssetImage("images/carousel1.jpg"),
      AssetImage("images/carousel2.jpg"),
      AssetImage("images/carousel3.jpg")
    ];
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            menu(context),
            dash(context, list),
            navBar(context),
          ],
        ),
      ),
    );
  }

  Widget dash(context, List<AssetImage> list) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.8 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedOpacity(
          opacity: isCollapsed ? 1.0 : 0.4,
          duration: duration,
          child: Material(
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                      ),
                      items: list
                          .map((item) => Container(
                                child: Image(
                                  image: item,
                                  fit: BoxFit.cover,
                                  width: screenWidth,
                                ),
                              ))
                          .toList(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          dashboardCard(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListViewWidget(screenWidth: screenWidth),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isCollapsed) {
                              _controller.forward();
                              isCollapsed = !isCollapsed;
                            } else {
                              _controller.reverse();
                              isCollapsed = !isCollapsed;
                            }
                          });
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menu(context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: screenHeight * 14 / 100,
            width: screenWidth * 78 / 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/carousel1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 9 / 100),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/circleAvatar.jpg"),
                  radius: 50,
                ),
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "BRAIN CANNISTER",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.mapMarker,
                      size: 18, color: Colors.blue),
                  Text("Mumbai"),
                ],
              ),
              SizedBox(height: screenHeight * 10 / 100),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 25.0),
                      rowWidget(Icons.phone, "Contact Us"),
                      SizedBox(height: 15.0),
                      rowWidget(Icons.arrow_upward_outlined, "My Growth"),
                      SizedBox(height: 15.0),
                      rowWidget(Icons.book, "My Education"),
                      SizedBox(height: 15.0),
                      rowWidget(Icons.center_focus_strong, "My Target"),
                      SizedBox(height: 15.0),
                      rowWidget(Icons.text_snippet_outlined, "My Tests"),
                      SizedBox(height: 15.0),
                      rowWidget(Icons.attach_money, "Payments"),
                      SizedBox(height: 15.0),
                      rowWidget(Icons.tv, "News and Blogs"),
                      SizedBox(height: screenHeight * 0.18),
                      Row(
                        children: [
                          Text("Tap Here to",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500)),
                          Text(" Log Out",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget rowWidget(IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black,
        ),
        SizedBox(width: 22.0),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Card dashboardCard() {
    return Card(
      elevation: 2.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: screenWidth * 0.4,
            width: screenWidth * 0.4,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    startAngle: 270,
                    endAngle: 270,
                    showLabels: false,
                    showTicks: false,
                    radiusFactor: 0.6,
                    axisLineStyle: AxisLineStyle(
                        cornerStyle: CornerStyle.bothFlat,
                        color: Colors.black12,
                        thickness: 5),
                    pointers: <GaugePointer>[
                      RangePointer(
                          value: 70,
                          cornerStyle: CornerStyle.bothFlat,
                          width: 6,
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                          color: Colors.blue[900],
                          gradient: SweepGradient(colors: <Color>[
                            Colors.blue[500],
                            Colors.blue[900]
                          ], stops: <double>[
                            0.25,
                            0.75
                          ])),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          angle: 90,
                          axisValue: 5,
                          positionFactor: 0.2,
                          widget: Text("70" + '%',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900])))
                    ])
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("Academics"),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Personal Info"),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("Remaining"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget navBar(context) {
    return AnimatedPositioned(
      duration: navDuration,
      top: isCollapsed ? 0 : 0.1 * screenHeight,
      bottom: isCollapsed ? 0 : -0.1 * screenHeight,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 8.0,
                ),
              ],
            ),
            height: 58.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      setState(() {
                        highlightNavBarFlag = 1;
                      });
                    },
                    child: Icon(
                      Icons.home,
                      size: 30.0,
                      color:
                          highlightNavBarFlag == 1 ? Colors.blue : Colors.black,
                    )),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        highlightNavBarFlag = 2;
                      });
                    },
                    child: Icon(
                      Icons.dynamic_feed_sharp,
                      size: 30,
                      color:
                          highlightNavBarFlag == 2 ? Colors.blue : Colors.black,
                    )),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        highlightNavBarFlag = 3;
                      });
                    },
                    child: Icon(
                      Icons.text_snippet_outlined,
                      size: 30,
                      color:
                          highlightNavBarFlag == 3 ? Colors.blue : Colors.black,
                    )),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        highlightNavBarFlag = 4;
                      });
                    },
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color:
                          highlightNavBarFlag == 4 ? Colors.blue : Colors.black,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
