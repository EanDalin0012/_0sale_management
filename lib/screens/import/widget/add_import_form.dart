import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/screens/widgets/package_product_dropdown/package_product_page.dart';
import 'package:sale_management/screens/widgets/product_dropdown/product_page.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/share/model/key/product_key.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/screens/package_product/widgets/prefix_product.dart';

class AddImportForm extends StatefulWidget {
  final ValueChanged<int> onAddChange;

  AddImportForm({Key key, this.onAddChange}):super(key: key);

  @override
  _AddNewCategoryFormState createState() => _AddNewCategoryFormState();
}

class _AddNewCategoryFormState extends State<AddImportForm> {

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  Size size;
  var isClickSave = false;
  List<dynamic> vData = [];
  Map productItem;
  Map packageProductItem;
  Map vendorItem;
  var quantity = 0.0;
  var total = 0.0;
  var remark = '';
  var price = 0;

  var productController = new TextEditingController();
  var packageProductController = new TextEditingController();
  var vendorController = new TextEditingController();
  var quantityController = new TextEditingController();
  var totalController = new TextEditingController();
  var remarkController = new TextEditingController();

  Map product;
  Map packageProduct;

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
                save();
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.redAccent,
                child: Center(child: Text('Save', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
              ),
            )
          ]
      ),
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
                  Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                        Text("Import New Product", style: headingStyle),
                        Text(
                          "Complete your details.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  _buildProductField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildPackageProductField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildVendorField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildQuantityField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildTotalField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildRemarkField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _buildAddButton()
                      ]
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),

                ]
            )
          )
        )
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

  TextFormField _buildTotalField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: quantityController,
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


  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: quantityController,
      onChanged: (value) => checkFormValid(),
      decoration: InputDecoration(
        labelText: "Remark",
        hintText: "Enter remark",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
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

  TextFormField _buildPackageProductField() {
    return TextFormField(
      onTap: () async {
        final packageProduct = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PackageProductPage(
              product: this.product,
              packageProduct: this.packageProduct,
          )),
        );
        print('packageProduct: ${packageProduct}');
        if(packageProduct == null) {
          return;
        }
        // setState(() {
        //   this.product = product;
        //   productController.text = this.product.name;
        //   checkFormValid();
        // });
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: this.product != null ? PrefixProduct(url: this.product[ProductKey.url]) : null,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildVendorField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: vendorController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid vendor.";
        }
        return null;
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Vendor",
        hintText: "Select vendor",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
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
                ImportAddKey.product: this.productItem,
                ImportAddKey.packageProduct: this.packageProductItem,
                ImportAddKey.vendor: this.vendorItem,
                ImportAddKey.quantity: this.quantity,
                ImportAddKey.price: price,
                ImportAddKey.total: this.total,
                ImportAddKey.remark: this.remark
              };
              this.vData.add(data);
              widget.onAddChange(this.vData.length);
            });
          }
        },
      ),
    );
  }

  Future<void> _isValid({
    @required String body,
  }) {
    var padding = EdgeInsets.all(5);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text('Are you sure?'),
            content: Text(body, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault),),
            actions: <Widget>[
              FlatButton(
                child: Container(
                    padding: padding,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(FontAwesomeIcons.timesCircle,size: 25,color: Colors.white),
                            SizedBox(width: 5,),
                            Center(child: Text('Close', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: Colors.white),)),
                            SizedBox(width: 5,),
                          ],

                        )
                    )
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        });
  }

  void save() {
    this.isClickSave = true;
    if( _formKey.currentState.validate()) {
      print('validate');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => MemberSuccessScreen(
      //     isAddScreen: true,
      //     vData: {
      //       MemberKey.name: nameController.text,
      //       MemberKey.phone: phoneController.text,
      //       MemberKey.url: browsController.text,
      //       MemberKey.remark: remarkController.text
      //     },
      //   )),
      // );
    }
  }

  void checkFormValid() {
    if(isClickSave) {
      _formKey.currentState.validate();
    }
  }

}
