
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/share/model/stock_details_model.dart';

class StockDetailsScreen extends StatefulWidget {
  final List<ProductStockDetails> productStockDetails;
  StockDetailsScreen(this.productStockDetails);

  @override
  _StockDetailsState createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        padding: EdgeInsets.only(left: 2),
        child:
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.productStockDetails.length,
              itemBuilder: (context,index){
                return  Row(
                  children: <Widget>[
                    production(widget.productStockDetails[index], size)
                  ]
                );
              })
      ),
    );
  }

  Container production(ProductStockDetails productStockDetails, Size size) {
    final TextStyle stats = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white);
    return Container(
      width: size.width * 0.85,
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                productStockDetails.productName.toString(),
                style: stats,
              ),
              Text(
                productStockDetails.totalQuantity.toString(),
                style: stats,
              ),
             ]
          ),
          Padding(
            padding:EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Text(
                  'Quantity: - '+productStockDetails.soldQuantity.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.black54),
                ),
              ],
            ),
          ),
          Padding(
            padding:EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Text(
                  'Price: '+productStockDetails.price.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.black54),
                ),
              ],
            ),
          ),
          Padding(
            padding:EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Text(
                  'Total: '+productStockDetails.totalQuantity.toString() + ' USD',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.black54),
                ),
              ],
            ),
          ),
          Padding(
            padding:EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Net Income: '+productStockDetails.totalQuantity.toString() + ' USD',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.black54),
                ),
                FaIcon(FontAwesomeIcons.ellipsisV,size: 20 , color: Colors.white,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
