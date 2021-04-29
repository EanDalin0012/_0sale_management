import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/product/widget/product_form_edit.dart';

class EditProductBody extends StatelessWidget {
  final Map productItem;
  EditProductBody({this.productItem});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Container(
        height: MediaQuery.of(context).size.height,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                  Text("Edit Product", style: headingStyle),
                  Text(
                    "Complete your details",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  ProductFormEdit(productItem: productItem,)
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
