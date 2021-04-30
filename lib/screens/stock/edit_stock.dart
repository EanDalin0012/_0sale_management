import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/category_success_screen.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/screens/stock/widget/edit_stock_form.dart';

class EditStockScreen extends StatefulWidget {
  final Map stock;
  EditStockScreen({ @required this.stock});

  @override
  _AddNewCategoryScreenState createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<EditStockScreen> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Stock"),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategorySuccessScreen()),
                    );
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
          ],
        ),
      ),
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
                          Text("Update Stock", style: headingStyle),
                          Text(
                            "Complete your details.",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    EditStockForm(stock: widget.stock),
                  ])
          ),
        )
    );
  }
}
