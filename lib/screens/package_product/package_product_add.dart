import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/category.dart';
import 'package:sale_management/screens/package_product/widgets/package_product_form_add.dart';
class PackageProductAdd extends StatefulWidget {
  @override
  _PackageProductAddState createState() => _PackageProductAddState();
}

class _PackageProductAddState extends State<PackageProductAdd> {

  var borderColorsTextField = Colors.deepPurple;
  var labelStyle = TextStyle(fontSize: 20, color: Colors.deepPurple, fontFamily: fontFamilyDefault);
  var hintStyle = TextStyle(fontFamily: fontFamilyDefault);
  var nameValueController = new TextEditingController();
  var quantityValueController = new TextEditingController();
  var priceValueController = new TextEditingController();
  var remarkValueController = new TextEditingController();

  var textValue = 'Select Product';
  var colorValue = Colors.deepPurple;
  Map<String, Object> dropdownValue;

  Size size;
  @override
  Widget build(BuildContext context) {
     size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _body(),
            Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _save();
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
      ),
    );
  }


  AppBar _appBar() {
    return AppBar(
        title: Text('Package of Product', style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900]
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
                          Text("Register Package Product", style: headingStyle),
                          Text(
                            "Complete your details",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    PackageProductForm(),
                  ])
          ),
        )
    );
  }

  _save() {
    var categoryModel = new CategoryModel(nameValueController.text, remarkValueController.text);
    print(categoryModel.toString());
  }

  Widget buildListTile({
    @required String title,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }

  Widget buildCountryPicker({
    @required String title,
    @required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );

}
