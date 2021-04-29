import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/share/model/stock_details_model.dart';

class ProductCard extends StatefulWidget {

  final ProductStockDetails productStockDetails;
  final int index;
  ProductCard(this.productStockDetails, this.index);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final TextStyle stats = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black54);
  final TextStyle stats1 = TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.black54);
  var textStyle = TextStyle(color: Colors.purple[900],fontSize: 18.0,fontWeight: FontWeight.w700, fontFamily: 'roboto, khmer siemreap');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var color;
    if (widget.index % 2 == 0) {
      color = Color(0xffd9dbdb).withOpacity(0.9);
    } else {
      color = Colors.deepOrangeAccent;
    }
    return Container(
      height: 150,
      width: size.width - 100,
      margin: EdgeInsets.only(
        left: 5,
        right: 5
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: Colors.white, width: 2),

      ),
      child: Container(
        height: 150,
        width: size.width,
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.productStockDetails.productName , style: textStyle),
                  Text(widget.productStockDetails.totalQuantity.toString(),style: stats),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Quantity: - '+widget.productStockDetails.soldQuantity.toString() , style: textStyle)
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Price: '+widget.productStockDetails.price.toString()+' USD' , style: textStyle)
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Total: '+widget.productStockDetails.total.toString() +' USD' , style: textStyle)
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Net Income: '+widget.productStockDetails.netIncome.toString() +' USD' , style: textStyle),
                  FaIcon(FontAwesomeIcons.ellipsisV,size: 25 , color: Colors.deepPurple,)
                ],
              ),
            ]
        ),
      ),
    );
  }
}
