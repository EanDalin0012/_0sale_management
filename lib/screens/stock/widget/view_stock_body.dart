import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/model/key/stock_detail_key.dart';
import 'package:sale_management/share/utils/number_format.dart';

class ViewStockBody extends StatefulWidget {
  final Map vData;
  const ViewStockBody({Key key, this.vData}) : super(key: key);

  @override
  _ViewStockBodyState createState() => _ViewStockBodyState();
}

class _ViewStockBodyState extends State<ViewStockBody> {

  List<dynamic> vData = [];

  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Stock", style: headingStyle),
                Text(
                  "Details stock of product.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          _buildStockName(context),
          this.vData.length > 0 ? Column(
            children: this.vData.map((item) {
              return _buildProductCard(item);
            }).toList(),
          ) : CircularProgressLoading(),
          // _buildProductCard(),
          // _buildProductCard(),
        ],
      ),
    );
  }

  Widget _buildCardSell(Map item) {
    return Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,
        //margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0XFFAEA1E5).withOpacity(0.3),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 3,
          //     blurRadius: 7,
          //     offset: Offset(0, 2), // changes position of shadow
          //   ),
          // ],
        ),
        child: Container(
          width: 160.0,
          //padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 9.0),
          decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(25.0)
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Sell",
                      style: TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: fontFamilyDefault),
                    ),
                  _offsetPopup(widget.vData),
                    // IconButton(
                    //   icon: Icon(Icons.more_vert, color: Colors.white,),
                    //   onPressed: () {
                    //     _offsetPopup(widget.vData);
                    //   },
                    // )
                  ],
                ),
                Text(
                  "Quantity: "+item[StockDetailsKey.quantity].toString(),
                  style: TextStyle(color: dropColor, fontSize: 15.0),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Total: " + FormatNumber.usdFormat2Digit(item[StockDetailsKey.total].toString()) + " USD",
                  style: TextStyle(color: dropColor, fontSize: 15.0),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildProductCard(Map data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 330,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0XFFAEA1E5).withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        width: 160.0,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(data[StockDetailsKey.productName],
                style: TextStyle( color: dropColor, fontSize: 20.0, fontFamily: fontFamilyDefault)
            ),
            SizedBox(
              height: 10,
            ),
            _buildCardSell(data[StockDetailsKey.sell]),
            _buildCardInStock(data[StockDetailsKey.inStock])
          ],
        ),
      ),
    );
  }

  Widget _buildCardInStock(Map item) {
    return Container(
        height: 110.0,
        width: MediaQuery.of(context).size.width,
        //margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0XFFAEA1E5).withOpacity(0.3),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 3,
          //     blurRadius: 7,
          //     offset: Offset(0, 2), // changes position of shadow
          //   ),
          // ],
        ),
        child: Container(
          width: 160.0,
          //padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 9.0),
          decoration: BoxDecoration(
              color: Color(0XFFFFB259),
              borderRadius: BorderRadius.circular(25.0)
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "In Stock",
                  style: TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: fontFamilyDefault),
                ),
                SizedBox(height: 10),
                Text(
                  "Quantity: "+item[StockDetailsKey.quantity].toString(),
                  style: TextStyle(color: dropColor, fontSize: 15.0),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildStockName(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
        height: 50.0,
        width: w,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Color(0XFFAEA1E5).withOpacity(0.3)
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                },
                child: Container(
                  width: 50.0,
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Text(
                    widget.vData[StockKey.name].toString().substring(0,1),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: dropColor, fontWeight: FontWeight.bold, fontFamily: fontFamilyDefault),
                  )
                )
              ),

              GestureDetector(
                onTap: () {
                },
                child: Container(
                  width: w - 110,
                  padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                  decoration: BoxDecoration(
                      // color:  Colors.white,
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Text(
                    widget.vData[StockKey.name].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: dropColor,fontWeight: FontWeight.bold),
                  )
                )
              )
            ]
        )
    );
  }

  Widget _offsetPopup(Map item) => PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
          value: 2,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.edit,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                "View Transaction Sell",
                style: menuStyle,
              ),
            ],
          )
      )
    ],
    icon: FaIcon(FontAwesomeIcons.ellipsisV,size: 20,color: Colors.white),
    offset: Offset(0, 45),
    onSelected: (value) {
      // if(value == 0) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) =>
      //         EditStockScreen(stock: item)
      //     ),
      //   );
      // } else if (value == 2) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) =>ViewStockScreen(vData: item)),
      //   );
      // }
    },
  );

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/show_stock_by_product.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['stocks'];
      print('${this.vData}');
    });
    return this.vData;
  }

}
