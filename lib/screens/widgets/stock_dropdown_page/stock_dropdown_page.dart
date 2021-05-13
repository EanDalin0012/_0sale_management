import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/screens/widgets/icon_check/icon_check.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/m_key.dart';

class StockDropdownPage extends StatefulWidget {

  final Map vStock;
  const StockDropdownPage({Key key, this.vStock}) : super(key: key);

  @override
  _StockDropdownPageState createState() => _StockDropdownPageState();
}

class _StockDropdownPageState extends State<StockDropdownPage> {
  List<dynamic> vData = [];
  List<dynamic> vDataTmp = [];
  Size size;
  var isNative = false;

  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          if (this.vData.length > 0 ) _buildBody() else CircularProgressLoading(),
        ],
      )
    );
  }

  Widget _buildAppBar() {
    final label = 'Choose Category';

    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('$label'),
      actions: [
        IconButton(
          icon: Icon(this.isNative ? Icons.close : Icons.search),
          onPressed: ()  {
            setState(()  {
              if(this.isNative) {
                this.vData = vDataTmp;
              }
              this.isNative = !this.isNative;
            });
          },
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: size.width - 20,
                height: 65,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: SearchWidget(
                  hintText: 'Search name',
                  onChange: (value) {
                    setState(() {
                      this.vData = onItemChanged(value);
                    });
                  },
                )
            ),
          ],
        ),
      ) : null,
    );
  }

  Widget _buildBody () {
    return Expanded(
        child:  ListView.separated(
          itemCount: this.vData.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.purple[900].withOpacity(0.5),
          ),
          itemBuilder: (context, index) {
            return _buildListTile(
                dataItem: this.vData[index]
            );
          },
        )
    );
  }

  Widget _buildListTile({
    @required Map dataItem
  }) {
    var isCheck = false;
    if(widget.vStock != null && widget.vStock[StockKey.id] == dataItem[StockKey.id] ) {
      isCheck = true;
    }
    return ListTile(
      onTap: () => onSelectedItem(dataItem),
      title: Text( dataItem[StockKey.name],
        style: TextStyle( color: dropColor, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      subtitle: Text(
        dataItem[StockKey.remark],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
      ),
      trailing:  isCheck ? IconCheck() : null,
    );
  }

  void onSelectedItem(Map data) {
    Navigator.pop(context, data);
  }

  onItemChanged(String value) {
    var dataItems = vDataTmp.where((e) => e[StockKey.name].toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/stock_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['stocks'];
    });
    return this.vData;
  }
}
