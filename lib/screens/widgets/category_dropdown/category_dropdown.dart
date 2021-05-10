import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/model/key/category_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/widgets/icon_check/icon_check.dart';

class CategoryDropdownPage extends StatefulWidget {
  final Map vCategory;

  CategoryDropdownPage({Key key, this.vCategory}) : super(key: key);

  @override
  _CategoryDropdownPageState createState() => _CategoryDropdownPageState();
}

class _CategoryDropdownPageState extends State<CategoryDropdownPage> {

  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
  var isNative = false;
  var text = '';
  var controller = TextEditingController();
  var isItemChanged = false;

  List<dynamic> vData = [];
  List<dynamic> vDataTmp = [];
  var vDataLength = 0;
  Size size;

  @override
  void initState() {
    super.initState();
    this._fetchListItems();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          if (vDataLength > 0 ) _buildBody() else CircularProgressLoading(),
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
                this.vDataLength = this.vData.length;
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
                      this.vDataLength = this.vData.length;
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
          itemCount: vDataLength,
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
    if(widget.vCategory != null && widget.vCategory[CategoryKey.id] == dataItem[CategoryKey.id] ) {
      isCheck = true;
    }
    return ListTile(
      onTap: () => onSelectedItem(dataItem),
      title: Text( dataItem[CategoryKey.name],
        style: TextStyle( color: dropColor, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      subtitle: Text(
          dataItem[CategoryKey.remark],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
      ),
      trailing:  isCheck ? IconCheck() : null,
    );
  }


  void onSelectedItem(Map data) {
    Navigator.pop(context, data);
  }

  onItemChanged(String value) {
    var dataItems = vDataTmp.where((e) => e[CategoryKey.name].toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }

  _fetchListItems() async {
    final data = await rootBundle.loadString('assets/json_data/category_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['categoryList'];
      this.vDataTmp = this.vData;
      this.vDataLength = this.vData.length;
    });
    return this.vData;
  }


}
