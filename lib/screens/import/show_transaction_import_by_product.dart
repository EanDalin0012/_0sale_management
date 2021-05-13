import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/import/import.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/model/key/product_import_key.dart';
import 'package:sale_management/share/utils/format_date.dart';
import 'package:sale_management/share/utils/number_format.dart';

class ShowTransactionImportByProduct extends StatefulWidget {
  final Map vProductImport;
  const ShowTransactionImportByProduct({Key key, this.vProductImport}) : super(key: key);

  @override
  _ShowTransactionImportByProductState createState() => _ShowTransactionImportByProductState();
}

class _ShowTransactionImportByProductState extends State<ShowTransactionImportByProduct> {

  var isNative = false;
  Size size;
  List<dynamic> vData = [];
  var color = Color.fromRGBO(58, 66, 86, 1.0);

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
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Center(
              child: Column(
                children: <Widget>[// 4%
                  Text("Import By Product", style: headingStyle),
                  Center(
                    child: Text(
                      "Show Transaction Import By Product",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            if(widget.vProductImport != null)
              _buildProductListTile(),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            if (this.vData.length > 0 ) _buildTransaction() else CircularProgressLoading(),
          ],
        )
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Import'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImportScreen()),
          );
        },
      ),
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
          ],
        ),
      ): null,
    );
  }
  Widget _buildTransaction() {
    return Expanded(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: this.vData.map((e)  {
            List<dynamic> mData = e['transactionInfo'];
            var mDataLength = mData.length;
            var i = 0;
            return Container(
              width: size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Color(0xCD939BA9).withOpacity(0.5),
                      width: size.width,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        FormatDate.dateFormat(yyyyMMdd: e[ImportKey.transactionDate].toString()),
                        style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    Column(
                      children: mData.map((item) {
                        i += 1;
                        return Container(
                          decoration: mDataLength != i ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xCD939BA9).withOpacity(0.2), width: 1.5),
                              )
                          ) : null,
                          child: _buildListTile(
                              transactionId: item[ImportKey.transactionId].toString(),
                              transactionDate: e[ImportKey.transactionDate].toString(),
                              time: item[ImportKey.time].toString(),
                              total: item[ImportKey.total].toString()
                          ),
                        );
                      }).toList()
                    )
                  ],
                )
            );
          } ).toList(),
        )
      ),
    );
  }

  Widget _buildListTile({
    @required String transactionId,
    @required String transactionDate,
    @required String time,
    @required String total,
  }) {
    return ListTile(
      leading: _buildLeading(),
      title: Text(
        transactionId,
        style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontFamily: fontFamilyDefault),
      ),
      subtitle: Text(
        FormatDate.dateTime(hhnn: time) + ', Quantity : 10' ,
        style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black.withOpacity(0.8)),
      ),
      trailing: Container(
        width: 110,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                FormatNumber.usdFormat2Digit(total).toString() + ' \$',
                style: TextStyle(fontFamily: fontFamilyDefault, fontSize: 20, fontWeight: FontWeight.w700, color: color),
              ),
              // SizedBox(width: 10,),
              // FaIcon(FontAwesomeIcons.chevronRight,size: 20 , color: Colors.black54.withOpacity(0.5))
            ]
        ),
      ),
    );
  }

  Widget _buildLeading() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.7), width: 2),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.transparent,
        child: FaIcon(FontAwesomeIcons.receipt,size: 20 , color: Colors.deepPurple),
      ),
    );
  }

  Widget _buildProductListTile() {
    return ListTile(
      leading: _buildLeadingProduct(url: widget.vProductImport[ProductImportKey.url]),
      title: Text(widget.vProductImport[ProductImportKey.name], style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700),),
      trailing: Text('Total Quantity: '+widget.vProductImport[ProductImportKey.totalQuantity].toString(),
        style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 20),),
    );
  }

  Widget _buildLeadingProduct({
    @required  String url
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
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
    final data = await rootBundle.loadString('assets/json_data/import_transactions.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['imports'];
    });
    return this.vData;
  }
}
