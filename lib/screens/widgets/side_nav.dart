import 'package:flutter/material.dart';
import 'package:sale_management/screens/management/management.dart';
import 'package:sale_management/share/constant/text_style.dart';

class SideNave extends StatelessWidget {
  Size size;
  var numItems = 20;
  var logo = '';
  var leftSub = 10.0;
  var style = TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print('${size.height}');
    return Drawer(
            child: SafeArea(
              top: false,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 15),
                          color: Color(0xFF88070B),
                          child:Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.asset("assets/images/profile.jpg", width: 80, height: 80, fit: BoxFit.fill,),
                              ),
                              SizedBox(width: 15,),
                              RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: "Name Surname\n", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamilyDefault, color: Colors.white)),
                                        TextSpan(text: "@username", style: TextStyle(fontFamily: fontFamilyDefault, color: Colors.white)),
                                      ]
                                  )
                              )
                            ],
                          )
                        ),
                        ListTile(title: Text("Contact Us", style: style,), leading: Icon(Icons.phone),),
                        ListTile(title: Text("Terms & Condition", style: style), leading: Icon(Icons.card_giftcard),),
                        Divider(),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: Text("Settings",style: style), leading: Icon(Icons.settings),),
                        // ListTile(title: Text("About"), leading: Icon(Icons.info),),
                        // ListTile(title: Text("Logout"), leading: Icon(Icons.exit_to_app),),
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: new Text(
                                "Logout",
                                style: new TextStyle(
                                  // fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  // color: AppTheme.darkText,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              trailing: new Icon(
                                Icons.power_settings_new,
                                color: Colors.red,
                              ),
                              onTap: () {},
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0,),
                          color: Colors.grey.shade200,
                          child: Text("2.20.00"),
                        )
                      ]
                  ),
                ),
              ),
            )
    );
  }

  Container buildUserInfo(context) => Container(
    color: Color(0xFF88070B),
    // height: MediaQuery.of(context).size.height * 0.3,
    width: MediaQuery.of(context).size.height,
    padding: EdgeInsets.only(bottom: 25.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildProfile(
          color: Colors.white,
          height: 70.0,
          width: 70.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
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

      ],
    ),
  );

  Container _buildProfile({double height, width, Color color}) {
    return Container(
      width: width,
      height: height,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepPurpleAccent,
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
