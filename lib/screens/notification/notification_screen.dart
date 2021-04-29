import 'package:flutter/material.dart';
import 'package:sale_management/screens/home/HomeScreen.dart';
import 'package:sale_management/screens/home/home_screen.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: new Container(),
    );
  }

  AppBar appBar () {
    return AppBar(
        centerTitle: true,
        title: Text('Notification'),
        backgroundColor: Colors.purple[900],
        // leading: Container(
        //   padding: EdgeInsets.only(
        //       top: 5
        //   ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     IconButton(
          //       icon: const Icon(Icons.navigate_before,size: 30),
          //       tooltip: 'Show Snackbar',
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => HomeScreen()),
          //         );
          //       },
          //     ),
          //   ],
          // ),
        // )
    );
  }
}
