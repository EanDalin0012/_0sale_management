import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sale_management/screens/home/HomeScreen.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/home/widgets/sheet_container.dart';
import 'package:sale_management/screens/notification/notification_screen.dart';
import 'package:sale_management/screens/sale/sale_screen.dart';
import 'package:sale_management/screens/widgets/side_nav.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/static/language_static.dart';

class Home extends StatefulWidget {
  Home():super();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String _titleBar = 'Home';
  var isShowAppBar = true;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SaleScreen(),
    HomeScreen1(),
  ];

  BottomNavigationBar _bottomNavigationBar() {
    double activeIconSize = 36;
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Feather.home,
            color: kGoodLightGray,
          ),
          title: Text('HOME'),
          activeIcon: Icon(
            Feather.home,
            color: kGoodPurple,
            size: 30,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Feather.plus_circle,
            color: kGoodLightGray,
          ),
          title: Text('CALENDAR'),
          activeIcon: Icon(
            Feather.plus_circle,
            color: kGoodPurple,
            size: activeIconSize,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Feather.align_left,
            color: kGoodLightGray,
          ),
          title: Text('PROFILE'),
          activeIcon: Icon(
            Feather.align_left,
            color: kGoodPurple,
            size: activeIconSize,
          ),
        ),
      ],
      onTap: (index) {
        setState(() {
          if(index == 0) {
            isShowAppBar = true;
            _titleBar = 'Home';
          } else if (index == 1) {
            _titleBar = 'Sale';
            isShowAppBar = false;
          }
          if(index >= 2) {
            _showModelSheet();
          } else {
            _selectedIndex = index;
          }
        });
      },
    );
  }

  Container _showModelSheet() {
    var orientation = MediaQuery.of(context).orientation;
    double height = (MediaQuery.of(context).copyWith().size.height * 0.6);
    setState(() {
      if(orientation != Orientation.portrait){
        height = MediaQuery.of(context).copyWith().size.height * 0.5;
      }
    });
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext builder) {
          return Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            child: SheetContainer(context),
          );
        });
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(_titleBar),
      backgroundColor: Colors.purple[900],
      elevation: 0,
      leading: Builder(builder: (context) {
        return IconButton(
            icon: Icon(Icons.sort_rounded),
            onPressed: () => Scaffold.of(context).openDrawer());
      },),
      actions: <Widget>[
        InkWell(
          onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
          },
          child: Container(
                  height: 80,
                  width: 55,
                  child: Stack(
                    children: <Widget>[
                      Center(child:  Icon(Icons.notifications)),
                      Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(
                            top: 5,
                            left: 30
                          ),
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.5),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(child: Text('2', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800))),
                        ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Future<bool> _onBackPressed() {
    var padding = EdgeInsets.all(5);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Container(
                    padding: padding,
                    decoration: BoxDecoration(
                      color: Colors.red[700].withOpacity(0.2),//Color(0xffd9dbdb).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(FontAwesomeIcons.timesCircle,size: 25,color: Colors.red),
                            SizedBox(width: 5,),
                            Center(child: Text('No',style: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),)),
                            SizedBox(width: 5,),
                          ],

                        )
                    )
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Container(
                    padding: padding,
                    decoration: BoxDecoration(
                      color: Colors.purple[900].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // SizedBox(width: 5,),
                            FaIcon(FontAwesomeIcons.checkCircle,size: 25,color: Colors.purple[900]),
                            SizedBox(width: 5,),
                            Center(child: Text('Yes',style: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),)),
                            SizedBox(width: 5,),
                          ],

                        )
                    )
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  // SystemNavigator.pop();
                },
              ),
            ],
          );
        });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isShowAppBar ? _appBar(): null,
        drawer: SideNave(),
        bottomNavigationBar: _bottomNavigationBar(),
        body: WillPopScope(
            onWillPop: _onBackPressed,
            child: _widgetOptions.elementAt(_selectedIndex)),
      );
  }
  showMessage({String data}) {
    return AlertDialog(
        title: Text(data.toString())
    );
    // _showToast();

  }
}
