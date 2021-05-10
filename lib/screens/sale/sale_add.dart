import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/sale/sale_add_confirm.dart';
import 'package:sale_management/screens/sale/widgets/sale_add_form.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/country_dropdown/country_page.dart';
import 'package:sale_management/screens/widgets/country_dropdown/flag_widget.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/country.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/model/key/product_key.dart';
import 'package:sale_management/share/model/package_product.dart';
import 'package:sale_management/share/utils/number_format.dart';
import 'package:sale_management/screens/sale/widgets/sale_items.dart';

class SaleAddScreen extends StatefulWidget {
  @override
  _PackageProductAddState createState() => _PackageProductAddState();
}

class _PackageProductAddState extends State<SaleAddScreen> {

  var borderColorsTextField = Colors.deepPurple;
  var labelStyle = TextStyle(fontSize: 20, color: Colors.deepPurple, fontFamily: fontFamilyDefault);
  var hintStyle = TextStyle(fontFamily: fontFamilyDefault);
  var quantityValueController = new TextEditingController();
  var totalValueController = new TextEditingController();
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
  var textValue = 'Select Product';
  var colorValue = Colors.deepPurple;
  var cartArrowDownCount = 0 ;
  double price;
  double quantity;
  var keyboardType = TextInputType.number;

  Map<String, Object> dropdownValue;
  CountryModel country;
  Map product;
  PackageProductModel packageProductModel;
  List<dynamic> vData = [];
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
                  onTap: () async {
                    final feedBackData = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SaleAddConfirm(vData: this.vData)),
                    );
                    print('feedBackData: ${feedBackData}');
                    setState(() {
                      this.vData = feedBackData;
                      this.cartArrowDownCount = this.vData.length;
                    });
                  },
                  child: Container(
                    width: size.width,
                    height: 45,
                    color: Colors.red,
                    child: Center(child: Text('Next', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
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
        title: Text('Sale', style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900],
        actions: <Widget>[
          InkWell(
            onTap: () {
              _showModelSheet();
            },
            child: Container(
              height: 80,
              width: 55,
              child: Stack(
                children: <Widget>[
                  Center(child:  FaIcon(FontAwesomeIcons.cartArrowDown,size: 25 , color: Colors.white,),),
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(
                        top: 5,
                        left: 30
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(child: Text(cartArrowDownCount.toString(), style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800))),
                  ),
                ],
              ),
            ),
          ),
        ]
    );
  }

  Expanded _body() {
    return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 10),
              physics: ClampingScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                          Text("Sale Items", style: headingStyle),
                          Text(
                            "Complete your details",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
                    SaleAddForm(),
                    SizedBox(height: 15,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          _buildAddButton()
                        ]
                    )
                  ])
          ),
        )
    );
  }

  Widget _buildPrice() {
    var pr = '00.00';
    if(this.price != null) {
     pr =  FormatNumber.usdFormat2Digit(this.price.toString());
    }
    return Container(
        margin: EdgeInsets.only(
            left: 15,
            top: 5
        ),
        child: Text('Price: ${pr} USD', style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500, fontSize: 15, color: Colors.red.withOpacity(0.8)),));
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
          setState(() {
            if(this.product == null) {
              _isValid(
                body: 'Please select product!'
              );
              return;
            } else if (this.packageProductModel == null) {
              _isValid(
                  body: 'Please select package product!'
              );
              return;
            } else if (this.quantityValueController.text == null || this.quantityValueController.text.trim() == '') {
              _isValid(
                  body: 'Invalid Quantity!'
              );
              return;
            } else if (this.totalValueController.text == null || this.totalValueController.text.trim() == '') {
              _isValid(
                  body: 'Invalid Total!'
              );
              return;
            } else {
              Map data = {
                SaleAddItemKey.productId: this.product[ProductKey.id],
                SaleAddItemKey.productUrl: this.product[ProductKey.url],
                SaleAddItemKey.productName: this.product[ProductKey.name],
                SaleAddItemKey.packageProductName: this.packageProductModel.name,
                SaleAddItemKey.quantity: quantityValueController.text,
                SaleAddItemKey.price: this.packageProductModel.price,
                SaleAddItemKey.total: totalValueController.text
              };
              this.cartArrowDownCount = this.vData.length;
              this.product = null;
              this.quantityValueController.text = '';
              this.totalValueController.text = '';
              this.packageProductModel = null;
              this.price = 0.0;
            }
          });
        },
      ),
    );
  }

  Widget buildSingleCountry() {
    final onTap = () async {
      final country = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CountryPage()),
      );

      if (country == null) return;

      // setState(() => this.country = country);
      // countries.add(this.country);
      // isMultiSelection = true;
    };

    return buildCountryPicker(
      title: 'Select Country',
      child: country == null ? buildListTile(title: 'No Country', onTap: onTap)
          : buildListTile(
        title: country.name,
        leading: FlagWidget(code: country.code),
        onTap: onTap,
      ),
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

  String _calTotal(double price, double quantity) {
    if(price> 0 && quantity > 0) {
        return FormatNumber.usdFormat2Digit((price * quantity).toString());
    } else {
      return '0';
    }
  }

  Container _showModelSheet() {
    var orientation = MediaQuery.of(context).orientation;
    double height = (MediaQuery.of(context).copyWith().size.height * 0.95);
    setState(() {
      if(orientation != Orientation.portrait){
        height = MediaQuery.of(context).copyWith().size.height * 0.5;
      }
    });

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext builder) {
          return Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.deepPurpleAccent.withOpacity(0.5)
            ),
              child: SaleItems(
                vData: this.vData,
                onChanged: (vChangeData) {
                  setState(() {
                    this.vData = vChangeData;
                    this.cartArrowDownCount = this.vData.length;
                  });
                },
              ),
          );
        });
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
                      color: Colors.red,//Color(0xffd9dbdb).withOpacity(0.4),
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

}
