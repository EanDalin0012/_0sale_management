import 'package:flutter/material.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/vendor/add_vendor.dart';

class VendorScreen extends StatefulWidget {
  @override
  _VendorState createState() => _VendorState();
}

class _VendorState extends State<VendorScreen> {
  var isNative = false;
  Size size ;
  List<dynamic> vData = [];
  var vDataLength = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              _container(),
            ],
          )
      ),
      floatingActionButton: _floatingActionButton()
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Vendors'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            this.isNative = !isNative;
            // this.isItemChanged = false;
            // this.isFilterByProduct = false;
          }),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: size.width - 40,
              height: 65,
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'Search name',
                onChange: (value) {
                  print('value ${value}');
                },
              ),
            ),
            // _buildFilterByCategory()
            // _buildFilterByProduct()
          ],
        ),
      ): null,
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
            'Vendor List',
            style: containStyle,
          ),
          Text(this.vDataLength.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault),)
        ],
      ),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddVendorScreen()),
        );
      },
      tooltip: 'Increment',
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

}
