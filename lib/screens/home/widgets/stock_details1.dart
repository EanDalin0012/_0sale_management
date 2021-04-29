import 'package:flutter/material.dart';
import 'package:sale_management/share/model/stock_details_model.dart';

class StockDetailsScreen1 extends StatefulWidget {

  final List<ProductStockDetails> productStockDetails;
  StockDetailsScreen1(this.productStockDetails);

  @override
  _StockDetailsScreenState createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen1> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 32, left: 32),
              child: Text(
                "Top Courses",
              ),
            ),
          ),
        ]
    );
  }
}
