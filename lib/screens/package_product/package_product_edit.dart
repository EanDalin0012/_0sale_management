import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/product_key.dart';
import 'package:sale_management/share/model/package_product.dart';
import 'package:sale_management/share/services/load_data_local.dart';
import 'package:sale_management/screens/package_product/widgets/package_product_form_edit.dart';

class PackageProductEdit extends StatefulWidget {

  final PackageProductModel packageProduct;
  PackageProductEdit({
    Key key,
    @required this.packageProduct
  }):super(key: key);

  @override
  _PackageProductAddState createState() => _PackageProductAddState();
}

class _PackageProductAddState extends State<PackageProductEdit> {

  _PackageProductAddState() {
    _fetchProductItems();
  }

  var borderColorsTextField = Colors.deepPurple;
  var labelStyle = TextStyle(fontSize: 20, color: Colors.deepPurple, fontFamily: fontFamilyDefault);
  var hintStyle = TextStyle(fontFamily: fontFamilyDefault);
  var nameValueController = new TextEditingController();
  var remarkValueController = new TextEditingController();
  var quantityValueController = new TextEditingController();
  var priceValueController = new TextEditingController();

  var textValue = 'Select Product';
  var colorValue = Colors.deepPurple;
  Map<String, Object> dropdownValue;
  List<dynamic> productItems = [];
  Map product;
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    nameValueController.text = widget.packageProduct.name;
    remarkValueController.text = widget.packageProduct.remark;
    quantityValueController.text = widget.packageProduct.quantity.toString();
    priceValueController.text    = widget.packageProduct.price.toString();

    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: PackageProductFormEdit(
          packageProduct: widget.packageProduct,
        )
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
                          Text("Update Package Product", style: headingStyle),
                          Text(
                            "Complete your details",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    PackageProductFormEdit(),
                  ])
          ),
        )
    );
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

  Future<void> _fetchProductItems() async {
    await LoadLocalData.fetchProductItems().then((value) {
      this.productItems = value;
      if(widget.packageProduct.productId > 0 && widget.packageProduct.productId != null) {
        setState(() {
          product = _searchProductById(widget.packageProduct.productId);
        });
      }
    });

  }

  Map _searchProductById(int productId) {
    if(this.productItems.length > 0) {
      for(Map p in productItems) {
        if(int.parse(p[ProductKey.id].toString()) == productId) {
          return p;
        }
      }
    }
  }

}
