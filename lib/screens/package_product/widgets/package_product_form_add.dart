import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/package_product/success_screen.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/screens/widgets/product_dropdown/product_page.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/screens/package_product/widgets/prefix_product.dart';
import 'package:sale_management/share/model/key/package_product_key.dart';
import 'package:sale_management/share/model/key/product_key.dart';

class PackageProductForm extends StatefulWidget {

  PackageProductForm({Key key}) : super(key: key);

  @override
  _PackageProductFormState createState() => _PackageProductFormState();
}

class _PackageProductFormState extends State<PackageProductForm> {

  var productNameController = new TextEditingController();
  var productController = new TextEditingController();
  var nameController = new TextEditingController();
  var qtyController = new TextEditingController();
  var priceController = new TextEditingController();
  var remarkController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  Size size;
  Map product;
  var autofocus = false;
  var isClickSave = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _body(),
          GestureDetector(
            onTap: () {
              KeyboardUtil.hideKeyboard(context);
              mySave();
            },
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              color: Colors.redAccent,
              child: Center(child: Text('Save', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
            ),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child:  Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                    Text("Register Package Product", style: headingStyle),
                    Text("Complete your details",textAlign: TextAlign.center,),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              _buildPackageNameField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildProductField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildQuantityField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildPriceField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildRemarkField(),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
            ],
          ),
        )
      ),
    );
  }
  TextFormField _buildPackageNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: nameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid package name.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter package name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildQuantityField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid quantity.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Quantity",
        hintText: "Enter quantity",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPriceField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: priceController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid price.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Price",
        hintText: "Enter price",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: remarkController,
      onChanged: (value) => checkFormValid(),
      decoration: InputDecoration(
        labelText: "Remark",
        hintText: "Enter remark",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  Widget _buildProductField() {
    return TextFormField(
        onTap: () async {
          final product = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage(productModel: this.product,)),
          );
          if(product == null) {
            return;
          }
          setState(() {
            this.product = product;
            productNameController.text = this.product[ProductKey.name];
            checkFormValid();
          });
        },
        readOnly: true,
        controller: productNameController,
        keyboardType: TextInputType.text,
        onChanged: (value) => checkFormValid(),
        validator: (value) {
          if (value.isEmpty) {
            return "Invalid product.";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Product",
          hintText: "Select product",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: this.product != null ? PrefixProduct(url: this.product[ProductKey.url]) : null,
          suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
        ),
      );
  }

  void mySave() {
    this.isClickSave = true;
    if( _formKey.currentState.validate()) {
      print('validate');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessScreen(
          isAddScreen: true,
          vData: {
            PackageProductKey.name: this.nameController.text,
            PackageProductKey.productId: this.product[ProductKey.id],
            PackageProductKey.quantity: this.qtyController.text,
            PackageProductKey.price: this.priceController.text,
            PackageProductKey.remark: this.remarkController.text
          },
        )),
      );
    }
  }

  void checkFormValid() {
    if(isClickSave) {
      _formKey.currentState.validate();
    }
  }

}
