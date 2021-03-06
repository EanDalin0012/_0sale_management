import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/package_product/widgets/prefix_product.dart';
import 'package:sale_management/screens/sale/sale_add_confirm.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/screens/widgets/package_product_dropdown/package_product_page.dart';
import 'package:sale_management/screens/widgets/product_dropdown/product_page.dart';
import 'package:sale_management/share/components/show_dialog/show_dialog.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/model/key/package_product_key.dart';
import 'package:sale_management/share/model/key/product_key.dart';
import 'package:sale_management/share/utils/number_format.dart';

class SaleAddForm extends StatefulWidget {
  final ValueChanged<List<dynamic>> onChange;
  SaleAddForm({Key key, this.onChange}):super(key: key);

  @override
  _SaleAddFormState createState() => _SaleAddFormState();
}

class _SaleAddFormState extends State<SaleAddForm> {

  Map product;
  Map packageProduct;
  List<dynamic> vData = [];

  var productController = new TextEditingController();
  var packageProductController = new TextEditingController();
  var quantityController = new TextEditingController();
  var totalController = new TextEditingController();

  var helperText = 'Please select product first.';
  var isSelectPackageProduct = false;
  var isClickSave = false;
  final _formKey = GlobalKey<FormState>();
  Size size;

  @override
  Widget build(BuildContext context) {
    return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _body(),
              GestureDetector(
                onTap: () {
                  KeyboardUtil.hideKeyboard(context);
                  save();
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.redAccent,
                  child: Center(child: Text('Next', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
                ),
              )

            ],
          )
        );
  }

  Widget _body() {
    return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Center(
                  child: Column(
                    children: <Widget>[
                      Text("Add New Items", style: headingStyle),
                      Text(
                        "Complete your details.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                _buildProductField(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                _buildPackageProductField(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                _buildQuantityField(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                _buildTotalField(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _buildAddButton()
                    ]
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
              ],
            )
          )
        )
    );
  }

  TextFormField _buildPackageProductField() {
    return TextFormField(
      onTap: () async {
        if(this.product != null) {
          final packageProduct = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PackageProductPage(
              product: this.product,
              packageProduct: this.packageProduct,
            )),
          );
          if(packageProduct == null) {
            return;
          }
          setState(() {
            this.packageProduct = packageProduct;
            packageProductController.text = this.packageProduct[PackageProductKey.name];
            quantityController.text = this.packageProduct[PackageProductKey.quantity].toString();
            var calTotal = (double.parse(quantityController.text) * double.parse(this.packageProduct[PackageProductKey.price].toString())).toString();
            totalController.text = FormatNumber.usdFormat2Digit(calTotal.toString()).toString();

            this.helperText = 'Price : '+FormatNumber.usdFormat2Digit(this.packageProduct[PackageProductKey.price].toString()).toString() + ' USD';
            this.isSelectPackageProduct = false;
            checkFormValid();
          });
        } else {
          setState(() {
            this.isSelectPackageProduct = true;
          });
        }

      },
      keyboardType: TextInputType.text,
      controller: packageProductController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if(this.product == null) {
          return "Invalid product.Please select product!";
        } else if (this.product != null && value.isEmpty) {
          return "Invalid package product.";
        }
        return null;
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Package Product",
        hintText: "Select package product",
        helperText: helperText,
        helperStyle: TextStyle(color: isSelectPackageProduct ? Colors.redAccent : dropColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: this.product != null ? PrefixProduct(url: this.product[ProductKey.url]) : null,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildQuantityField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: quantityController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid quanity.";
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

  TextFormField _buildProductField() {
    return TextFormField(
      onTap: () async {
        final product = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(productModel: this.product)),
        );
        if(product == null) {
          return;
        }
        setState(() {
          this.product = product;
          productController.text = this.product[ProductKey.name];
          this.helperText = '';
          checkFormValid();
        });
      },
      keyboardType: TextInputType.text,
      controller: productController,
      onChanged: (value) => checkFormValid(),
      readOnly: true,
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


  TextFormField _buildTotalField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: totalController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid total.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Total",
        hintText: "Enter total",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  Widget _buildAddButton() {
    return  Container(
      height: 50,
      width: 110,
      margin: EdgeInsets.only(right: 10),
      child: RaisedButton(
        color: Colors.red,
        textColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FaIcon(FontAwesomeIcons.plusCircle,size: 25 , color: Colors.white,),
            Center(child: Text("Add", style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),)),
          ],
        ),
        onPressed: () {
            this.isClickSave = true;
            KeyboardUtil.hideKeyboard(context);
            if( _formKey.currentState.validate()) {
              setState(() {
                    Map data = {
                      SaleAddItemKey.product: this.product,
                      SaleAddItemKey.packageProduct: this.packageProduct,
                      SaleAddItemKey.quantity: quantityController.text,
                      SaleAddItemKey.total: totalController.text
                    };
                    this.vData.add(data);
                    widget.onChange(this.vData);
                    this.isClickSave = false;
                    this.helperText = 'Please select product first.';
                    this.packageProduct = null;
                    this.product = null;
                    this.quantityController.clear();
                    this.totalController.clear();
                    this.productController.clear();
                    this.packageProductController.clear();
              });
            }
        },
      ),
    );
  }

  void save() {
    if(this.vData.length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SaleAddConfirm(
          vData: this.vData,
          onChanged: (items) {
            setState(() {
              this.vData = items;
              widget.onChange(this.vData);
            });
          },
        )),
      );
    } else {
      _showDialogCheckItems(content: 'Please add your import item(s).');
    }
  }

  void checkFormValid() {
    if(isClickSave) {
      _formKey.currentState.validate();
    }
  }

  void _showDialogCheckItems({String content}) {
    ShowDialog.showConfirm(
        buildContext: context,
        btnConfirm: 'Conf',
        content: Text(content),
        onPressedConfirm: () {
          print('confirm Click');
        }
    );
  }
}
