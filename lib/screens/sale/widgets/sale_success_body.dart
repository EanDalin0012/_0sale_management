import 'package:flutter/material.dart';
import 'package:sale_management/screens/sale/sale_screen.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/default_button/default_button.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/import_add_key.dart';
import 'package:sale_management/share/utils/number_format.dart';

class SaleSuccessBody extends StatelessWidget {
  final bool isAddScreen;
  final bool isEditScreen;
  final Map vData;
  SaleSuccessBody({Key key,this.isEditScreen, this.isAddScreen, this.vData}): super(key: key);

  final headingStyle = TextStyle(
      fontSize: getProportionateScreenWidth(28),
      fontWeight: FontWeight.bold,
      color: Colors.black,
      height: 1.5,
      fontFamily: fontFamilyDefault
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async {
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SaleScreen()),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: SizeConfig.screenHeight * 0.07),
          Center(
            child: Image.asset(
              "assets/icons/success-green-check-mark.png",
              height: SizeConfig.screenHeight * 0.2, //40%
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.07),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                if (this.isAddScreen == true)
                  Text("Sale Items", style: headingStyle),
                  Text(
                    "\nTransaction ID: ${this.vData[ImportTransactionKey.transactionID]} \n\nTotal : ${FormatNumber.usdFormat2Digit(this.vData[ImportAddKey.total].toString())} USD",
                    style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500, color: dropColor),
                  ),
              ],
            ),
          ),

          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Center(
            child: Text(
              "Success",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.7,
            child: DefaultButton(
              elevation: 3,
              text: "Back",
              color: Colors.green[800],
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaleScreen()),
                );
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
