import 'package:flutter/material.dart';
import 'package:sale_management/share/constant/text_style.dart';

class ProductBody extends StatelessWidget {
  int vDataLength = 0;
  Size size;
  List<dynamic> vData = [];
  @override
  Widget build(BuildContext context) {
    size =  MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
          children: <Widget>[
            _container(),
            // if (vDataLength > 0 ) _buildBody() else _buildLoadingScreen()
          ],
        ),
    );
  }

  Container _container() {
    this.vDataLength = this.vData.length;
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      width: size.width,
      padding: EdgeInsets.only(
          left: 20,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Package of Product List',
            style: containStyle,
          ),
          Text(this.vDataLength.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault),)
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }

}
