import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/sale/widgets/sale_add_form.dart';
import 'package:sale_management/screens/size_config.dart';

class AddSaleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                    Text("Sale Items", style: headingStyle),
                    Text(
                      "Complete your details",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
                    SaleAddForm()
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
