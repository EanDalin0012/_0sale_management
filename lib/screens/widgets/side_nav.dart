import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/management/management.dart';

class SideNave extends StatelessWidget {
  Size size;
  var numItems = 20;
  var logo = '';
  var leftSub = 10.0;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Drawer(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      buildUserInfo(context),
                      // _container(context),
                      // ListTile(title: Text("KYC Form"), leading: Icon(Icons.info),),
                      // ListTile(title: Text("My Bookings"), leading: Icon(FontAwesomeIcons.calendarDay),),
                      // ListTile(title: Text("My Purchases"), leading: Icon(FontAwesomeIcons.listOl),),
                      ListTile(title: Text("Transaction Limits"), leading: Icon(FontAwesomeIcons.chartLine),),
                      ListTile(title: Text("Coupan"), leading: Icon(Icons.card_giftcard),),
                      Divider(),
                      ListTile(title: Text("Play Khalti Quiz"), leading: Icon(FontAwesomeIcons.brain),),
                      ListTile(title: Text("Khalti Points"), leading: Icon(FontAwesomeIcons.coins),),
                      Divider(),
                      ListTile(title: Text("Settings"), leading: Icon(Icons.settings),),
                      Divider(),
                      ExpansionTile(
                        backgroundColor: Colors.grey.shade100,
                        title: Text("Management"),
                        leading: Icon(Icons.headset_mic),
                        children: <Widget>[
                          ListTile(
                            title: Container(
                                margin: EdgeInsets.only(left: leftSub),
                                child: Text("FAQ")
                            ),
                          ),
                          Divider(),
                          ListTile(title: Container(
                              margin: EdgeInsets.only(left: leftSub),
                              child: Text("FAQ")
                          )),
                          Divider(),
                          ListTile(title: Container(
                              margin: EdgeInsets.only(left: leftSub),
                              child: Text("FAQ")
                          )),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ManagementScreen()),
                          );
                        },
                        child: ListTile(title: Text("Management"), leading: Icon(Icons.settings),)),
                      ExpansionTile(
                        backgroundColor: Colors.grey.shade100,
                        title: Text("Help & Support"),
                        leading: Icon(Icons.headset_mic),
                        children: <Widget>[
                          ListTile(title: Text("FAQ"),),
                          ListTile(title: Text("Contact Us"),),
                          ListTile(title: Text("Feedback"),),
                        ],
                      ),
                      ListTile(title: Text("About"), leading: Icon(Icons.info),),
                      ListTile(title: Text("Logout"), leading: Icon(Icons.exit_to_app),),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0,),
                        color: Colors.grey.shade200,
                        child: Text("2.20.00"),
                      )
                    ]
                ),
              ),
            )
    );
  }

  Container buildUserInfo(context) => Container(
    color: Color(0xFF88070B),
    //height: deviceSize.height * 0.3,
    padding: EdgeInsets.only(bottom: 25.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
          },
          leading: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Good Afternoon!',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'MAUSAM'.toUpperCase(),
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        _buildProfile(
          color: Colors.white,
          height: 70.0,
          width: 70.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          'MAUSAM rayamajhi'.toUpperCase(),
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        )
      ],
    ),
  );

  Container _buildProfile({double height, width, Color color}) {
    return Container(
      width: width,
      height: height,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
            image: DecorationImage(
              image: AssetImage('assets/images/profile.jpg'),
              fit: BoxFit.contain,
            ),
          border: Border.all(
            color: color,
            width: 3.0,
          ),
        )
    );
  }

  // Container _container(BuildContext context) {
  //   return Container(
  //     // margin: const EdgeInsets.only(top: 50),
  //     // height: 170,
  //       color: Colors.purple,
  //       child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             ListTile(
  //               onTap: (){},
  //               leading: Stack(
  //                 overflow: Overflow.visible,
  //                 children: <Widget>[
  //                   CircleAvatar(
  //                     backgroundColor: Colors.white,
  //                     child: Image.network('https://static.dezeen.com/uploads/2020/10/gmail-google-logo-rebrand-workspace-design_dezeen_2364_sq.jpg'),
  //                   ),
  //                   Positioned(
  //                       bottom: -5,
  //                       right: -5,
  //                       child: Icon(Icons.remove_circle, color: Colors.red,))
  //                 ],
  //               ),
  //               title: Text("Damodar Lohani",style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 18.0
  //               ),),
  //               subtitle: Text("981151121", style: TextStyle(
  //                   fontSize: 16.0,
  //                   color: Colors.white
  //               ),),
  //               trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
  //             ),
  //           ]
  //       )
  //   );
  // }
}
