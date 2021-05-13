import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/import/transfter_to_stock_success.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/screens/widgets/stock_dropdown_page/stock_dropdown_page.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/model/key/product_import_key.dart';
import 'package:sale_management/share/model/key/transfer_to_stock_key.dart';

class TransferToStockBody extends StatefulWidget {
  final Map vImport;
  const TransferToStockBody({Key key, this.vImport}) : super(key: key);

  @override
  _TransferToStockBodyState createState() => _TransferToStockBodyState();
}

class _TransferToStockBodyState extends State<TransferToStockBody> {

  final _formKey = GlobalKey<FormState>();
  var isClickTransfer = false;
  var quantityController = new TextEditingController();
  var stockController = new TextEditingController();
  var remarkController = new TextEditingController();
  Map stock;
  var transferText = '';
  @override
  Widget build(BuildContext context) {
    this.quantityController.text = widget.vImport[ProductImportKey.totalQuantity].toString();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildForm(),
          GestureDetector(
            onTap: () {
              KeyboardUtil.hideKeyboard(context);
              save();
            },
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              color: Colors.redAccent,
              child: Center(child: Text('Transfer ' + transferText, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
            ),
          )
        ],
      )
    );
  }

  Widget _buildForm() {
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
                      Text("Transfer Product To Stock", style: headingStyle),
                      Text(
                        "Transfer product to stock for sale.\nComplete your details.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                _buildQuantityField(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                _buildStockField(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                _buildRemarkField()
              ],
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

  TextFormField _buildStockField() {
    return TextFormField(
      onTap: () async {
        final stockBackData = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StockDropdownPage(vStock: this.stock)),
        );
        if(stockBackData == null) {
          return;
        }
        setState(() {
          this.stock = stockBackData;
          stockController.text = this.stock[StockKey.name];
          this.transferText = this.stock[StockKey.name];
          checkFormValid();
        });
      },
      keyboardType: TextInputType.text,
      controller: stockController,
      onChanged: (value) => checkFormValid(),
      readOnly: true,
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid product.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Stock",
        hintText: "Select stock",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //prefixIcon: this.product != null ? PrefixProduct(url: this.product[ProductKey.url]) : null,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: remarkController,
      decoration: InputDecoration(
        labelText: "Remark",
        hintText: "Enter remark",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  void save() {
    this.isClickTransfer = true;
    if( _formKey.currentState.validate()) {
      print('validate');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TransferToStockSuccessScreen(
          vData: {
            TransferToStockKey.quantity: quantityController.text,
            TransferToStockKey.stock: this.stock,
            TransferToStockKey.remark: remarkController.text,
            TransferToStockResponseKey.transactionID: 'AXG20203020'
          },
        )),
      );
    }
  }

  void checkFormValid() {
    if(isClickTransfer) {
      _formKey.currentState.validate();
    }
  }
}
