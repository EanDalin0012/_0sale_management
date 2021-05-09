import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/package_product/success_screen.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/screens/widgets/product_dropdown/product_page.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/share/model/product.dart';
import 'package:sale_management/screens/package_product/widgets/prefix_product.dart';


class PackageProductForm extends StatefulWidget {

  PackageProductForm({Key key}) : super(key: key);

  @override
  _PackageProductFormState createState() => _PackageProductFormState();
}

class _PackageProductFormState extends State<PackageProductForm> {
  var productNameController = new TextEditingController();

  var name;
  var productName;
  var qty;
  var price;
  var remark;

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  Size size;
  ProductModel product;
  var autofocus = false;


  void addError({String error}) {

    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

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
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        _formKey.currentState.validate();
        if (value.isNotEmpty) {
          name = value;
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
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
      onSaved: (newValue) => qty = newValue,
      onChanged: (value) {
        _formKey.currentState.validate();
        this.qty = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
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
      onSaved: (newValue) => price = newValue,
      onChanged: (value) {
        _formKey.currentState.validate();
        price = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
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
      onChanged: (value) {
        this.remark = value;
      },
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
          setState(() {
            this.product = product;
            productNameController.text = this.product.name;
            _formKey.currentState.validate();
          });
        },
        readOnly: true,
        controller: productNameController,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          _formKey.currentState.validate();
          if (value.isNotEmpty) {
            productName = value;
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kEmailNullError);
            return "Invalid product.";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Product",
          hintText: "Select product",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: this.product != null ? PrefixProduct(url: this.product.url) : null,
          suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
        ),
      );
  }

  void mySave() {
    if( _formKey.currentState.validate()) {
      print('validate');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessScreen(
          isAddScreen: true,
        )),
      );
    }
  }

}
