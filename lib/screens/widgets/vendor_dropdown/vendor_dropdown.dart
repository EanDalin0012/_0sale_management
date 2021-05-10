import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/vendor_key.dart';
import 'package:sale_management/screens/widgets/icon_check/icon_check.dart';

class VendorDropDownPage extends StatefulWidget {
  final Map vVendor;

  const VendorDropDownPage({Key key, this.vVendor}) : super(key: key);

  @override
  _VendorDropDownPageState createState() => _VendorDropDownPageState();
}

class _VendorDropDownPageState extends State<VendorDropDownPage> {


  var isNative = false;
  Size size ;
  List<dynamic> vData = [];
  var vDataLength = 0;

  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            if (vDataLength > 0 ) _buildBody() else CircularProgressLoading()
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Select Vendors'),
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

  Widget _buildBody () {
    return Expanded(
        child: ListView.separated(
          itemCount: vDataLength,
          separatorBuilder: (context, index) => Divider(
            color: Colors.purple[900].withOpacity(0.5),
          ),
          itemBuilder: (context, index) {
            return _buildListTile(
                dataItem: this.vData[index]
            );},
        )
    );
  }

  Widget _buildListTile( {
    @required Map dataItem
  }) {
    return ListTile(
        onTap: () => onSelectedItem(dataItem),
      title: Text( dataItem[VendorKey.name],
        style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      subtitle: Text(
        dataItem[VendorKey.phone] + ',' +dataItem[VendorKey.email],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
      ),
      trailing: widget.vVendor != null && widget.vVendor[VendorKey.id] == dataItem[VendorKey.id] ? IconCheck() : null,
    );
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/vendor_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['vendors'];
      this.vDataLength = this.vData.length;
    });
    return this.vData;
  }

  void onSelectedItem(Map data) {
    Navigator.pop(context, data);
  }

}
