import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/product_import_key.dart';
import 'package:sale_management/share/utils/number_format.dart';

class ProductImportBody extends StatefulWidget {
  const ProductImportBody({Key key}) : super(key: key);

  @override
  _ProductImportBodyState createState() => _ProductImportBodyState();
}

class _ProductImportBodyState extends State<ProductImportBody> {

  List<dynamic> vData = [];

  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10),
        physics: ClampingScrollPhysics(),
        child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(),
          itemCount: this.vData.length,
          itemBuilder: (context, index) => _buildListTile(dataItem: this.vData[index]),
        )
      ),
    );
  }

  Widget _buildBody() {
    return ListView.separated(
      itemCount: vData.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.purple[900].withOpacity(0.5),
      ),
      itemBuilder: (context, index) {
        return _buildListTile(
            dataItem: this.vData[index]
        );
      },
    );
  }

  Widget _buildListTile( {
    @required Map dataItem
  }) {
    return ListTile(
      title: Text( dataItem[ProductImportKey.name],
        style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      leading: _buildLeading(url: dataItem[ProductImportKey.url]),
      subtitle: Text(
        dataItem[ProductImportKey.remark],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
      ),
      trailing: Container(
        width: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      FormatNumber.usdFormat2Digit(dataItem[ProductImportKey.totalQuantity].toString()).toString(),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                _offsetPopup(dataItem),
              ],
            ),

          ],
        ),
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
              Text('Edit',
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
              Text('Delete',
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) =>
        //       PackageProductEdit(packageProduct: item)
        //   ),
        // );
      } else if (value == 1) {
        // _showDialog(item);
      }
    },
  );

  Widget _buildLeading({
    @required  String url
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundImage:NetworkImage(url),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/product_imports.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['imports'];
    });
    return this.vData;
  }
}
