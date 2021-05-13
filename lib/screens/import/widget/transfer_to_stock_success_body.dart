import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/import/import.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/default_button/default_button.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/model/key/transfer_to_stock_key.dart';

class TransferToStockSuccessBody extends StatelessWidget {
  final Map vData;
  const TransferToStockSuccessBody({Key key,this.vData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stock = this.vData[TransferToStockKey.stock];
    return WillPopScope(
      onWillPop:  () async {
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImportScreen()),
        );
      },
      child: Column(
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
                Text("Transfer Product", style: headingStyle),
                Text("Please to check your stock "+stock[StockKey.name],textAlign: TextAlign.center,),
                Text(
                  "\nTransaction ID: ${this.vData[TransferToStockResponseKey.transactionID]} \n\nQuantity : ${this.vData[TransferToStockKey.quantity].toString()}",
                  style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500, color: dropColor),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
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
                  MaterialPageRoute(builder: (context) => ImportScreen()),
                );
              },
            ),
          ),
          Spacer(),
        ],
      )
    );
  }
}
