import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/model/category.dart';
import 'package:sale_management/screens/category/widget/edit_category_form.dart';

class EditCategoryBody extends StatelessWidget {
  final CategoryModel categoryModel;
  EditCategoryBody({
    @required this.categoryModel,
    Key key
  }):super(key: key);
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
                    Text("Edit Category", style: headingStyle),
                    Text(
                      "Complete your details",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    EditCategoryForm(
                      categoryModel: categoryModel,
                    )
                  ]
              ),
            ),
          )
        )
    );
  }
}
