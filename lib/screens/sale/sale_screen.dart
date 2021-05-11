import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/Home.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/sale_transaction.dart';
import 'package:sale_management/share/utils/format_date.dart';
import 'package:sale_management/share/utils/number_format.dart';
import 'package:sale_management/screens/sale/sale_add.dart';

class SaleScreen extends StatefulWidget {
  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  Size size ;
  var controller = TextEditingController();
  var isItemChanged = false;
  var isFilterByProduct = false;
  var isNative = false;
  List<SaleTransactionModel> items = [];
  List<SaleTransactionModel> itemsTmp = [];
  Map mapItems = new Map();
  List<dynamic> vData = [];
  int itemLength = 0;
  var menuStyle = TextStyle( color: Colors.purple[900], fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
 var color = Color.fromRGBO(58, 66, 86, 1.0);

  @override
  void initState() {
    super.initState();
    this.todayDate();
    this._fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: _buildAppBar(),
        body: WillPopScope(
          onWillPop:  () async {
            return Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints) {
                return Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: this.vData.length > 0 ? Column(
                              children: <Widget>[
                                SizedBox(height: 40,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: this.vData.map((e) {
                                    List<dynamic> mData = e['transactionInfo'];
                                    var mDataLength = mData.length;
                                    var i = 0;
                                    return Container(
                                        width: size.width,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                color: Color(0xCD939BA9).withOpacity(0.5),
                                                width: size.width,
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  FormatDate.dateFormat(yyyyMMdd: e['transactionDate'].toString()),
                                                  style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500, fontSize: 17),
                                                ),
                                              ),
                                              Column(
                                                  children: mData.map((item)
                                                  {
                                                    i += 1;
                                                    return Container(
                                                      decoration: mDataLength != i ? BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(color: Color(0xCD939BA9).withOpacity(0.2), width: 1.5),
                                                          )
                                                      ) : null,
                                                      child: _buildListTile(
                                                        transactionId: item['transactionId'].toString(),
                                                        transactionDate: e['transactionDate'].toString(),
                                                        total: item['total'].toString()
                                                      ),

                                                    );
                                                  }
                                                  ).toList()
                                              )
                                            ]
                                        )
                                    );
                                  }
                                  ).toList(),
                                ),
                                SizedBox(height: 50),
                              ]
                          ) : Container()
                        ),
                      )
                  ),
                  _container(),
                  ]
                );
              }),
        ),
        floatingActionButton: _floatingActionButton()
    );
  }

  Widget _container() {
    return Container(
        color: Color(0xFF939BA9),
        width: size.width,
        height: 40,
        padding: EdgeInsets.only(
            left: 20,
            right: 20
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Sale of Product List',
              style: TextStyle(color: Colors.black87.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'roboto,khmer siemreap'),
            ),
           Text(this.itemLength.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault),)
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
          MaterialPageRoute(builder: (context) => SaleAddScreen()),
        );
      },
      tooltip: 'Increment',
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
      ),
      title: Text('Sale of Products'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            this.isNative = !isNative;
            this.isItemChanged = false;
            this.isFilterByProduct = false;
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
            // _buildFilterByProduct()
          ],
        ),
      ): null,
    );
  }

  Widget _buildListTile({
    @required String transactionId,
    @required String transactionDate,
    @required String total,
  }) {
    return ListTile(
      leading: _buildLeading(),
      title: Text(
            transactionId,
            style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontFamily: fontFamilyDefault),
          ),
      subtitle: Text(
        FormatDate.dateTime(hhnn: transactionDate.toString().substring(8)),
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
              SizedBox(width: 10,),
              FaIcon(FontAwesomeIcons.chevronRight,size: 20 , color: Colors.black54.withOpacity(0.5))
            ]
        ),
      ),
    );
  }

  _fetchItems() async {
      final data = await rootBundle.loadString('assets/json_data/sale_transaction_list.json');
      Map mapItems = jsonDecode(data);
      setState(() {
        this.vData = mapItems['transactionList'];
        this.itemLength = this.vData.length;
      });
      return this.vData;
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

  todayDate() {
    print(formatDate(DateTime(1989, 2, 21,15, 40, 10), [yyyy, '-', MM, '-', dd, '-',hh,'-',nn, '-',ss]));
  }

}

const Color profile_info_background = Color(0xFF3775FD);
const Color profile_info_categories_background = Color(0xFF939BA9);
const Color furnitureCateDisableColor = Color(0xCD939BA9);
