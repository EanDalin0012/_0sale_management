import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/member/widget/edit_member_form.dart';

class EditMemberScreen extends StatefulWidget {
  final Map member;
  EditMemberScreen({@required this.member});

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<EditMemberScreen> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print('${widget.member}');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          foregroundColor: Colors.purple[900],
          title: Text("Member"),
        ),
        body: SafeArea(
          child: Column(
              children: <Widget>[
                _body(),
                Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: size.width,
                        height: 45,
                        color: Colors.red,
                        // margin: EdgeInsets.only(
                        //   left: 5,
                        //   right: 5
                        // ),
                        child: Center(child: Text('Update', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
                      ),
                    ),
                  ],
                )
              ]
          ),
        )
    );
  }

  Expanded _body() {
    return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                          Text("Update Member", style: headingStyle),
                          Text(
                            "Complete your details",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    EditMemberForm(),
                  ])
          ),
        )
    );
  }
}
