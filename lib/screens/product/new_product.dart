import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/product/widget/product_form_add.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/helper/keyboard.dart';

class NewProductScreen extends StatefulWidget {
  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          foregroundColor: Colors.purple[900],
          title: Text("Product"),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              _body(),
              Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      KeyboardUtil.hideKeyboard(context);
                    },
                    child: Container(
                      width: size.width,
                      height: 45,
                      color: Colors.red,
                      // margin: EdgeInsets.only(
                      //   left: 5,
                      //   right: 5
                      // ),
                      child: Center(child: Text('SAVE', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
                    ),
                  ),
                ],
              )
            ],
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
                          Text("Register Product", style: headingStyle),
                          Text(
                            "Complete your details",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    ProductFormAdd(),
                  ])
          ),
        )
    );
  }
}

