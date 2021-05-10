import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/Home.dart';
import 'package:sale_management/screens/vendor/edit_vendor.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/components/show_dialog/show_dialog.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/vendor/add_vendor.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/share/model/key/vendor_key.dart';

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
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
          child: WillPopScope(
            onWillPop:  () async {
              return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            child: Column(
              children: <Widget>[
                _container(),
                if (vDataLength > 0 ) _buildBody() else CircularProgressLoading()
              ],
            ),
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
      title: Text( dataItem[VendorKey.name],
        style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      subtitle: Text(
        dataItem[VendorKey.phone] + ',' +dataItem[VendorKey.email],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
      ),
      trailing: Column(
        children: <Widget>[
          _offsetPopup(dataItem),
        ],
      ),
    );
  }

  Widget _offsetPopup(Map item) => PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
          value: 0,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.edit,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                "Edit",
                style: menuStyle,
              ),
            ],
          )
      ),
      PopupMenuItem(
          value: 1,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.trash,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                "Delete",
                style: menuStyle,
              ),
            ],
          )
      ),
    ],
    icon: FaIcon(FontAwesomeIcons.ellipsisV,size: 20,color: Colors.black),
    offset: Offset(0, 45),
    onSelected: (value) {
      if(value == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditVendorScreen(vendor: item)),
        );
      } else if (value == 1) {
        _showDialog(item);
      }
    },
  );

  Widget _showDialog(Map item) {
    return ShowDialog.showDialogYesNo(
        buildContext: context,
        title: Text(item[VendorKey.name]),
        content: Text('Do you want to delete package of product : '+item[VendorKey.name]+'?'),
        btnRight: 'Yes',
        onPressedBntRight: () {
          print('onPressedBntRight');
        },
        btnLeft: 'No',
        onPressedBntLeft: () {
          print('onPressedBntLeft');
        }
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

}

