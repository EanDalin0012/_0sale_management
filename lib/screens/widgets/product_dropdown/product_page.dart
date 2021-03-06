import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/product_key.dart';
import 'package:sale_management/screens/widgets/icon_check/icon_check.dart';

class ProductPage extends StatefulWidget {
  final Map productModel;
  const ProductPage({
    Key key,
    this.productModel,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  var isNative = false;
  var text = '';
  var controller = TextEditingController();
  var isSearch = false;
  var isItemChanged = false;
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);

  int vDataLength = 0;
  List<dynamic> vData = [];
  List<dynamic> vDataTmp = [];

  @override
  void initState() {
    super.initState();
    this._fetchListItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
          children: <Widget>[
            if (this.vData.length > 0 ) _buildBody() else CircularProgressLoading(),
          ]
      ),
    );
  }

  Widget _buildBody () {
    return Expanded(
      child: ListView.separated(
        itemCount: this.vData.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.purple[900].withOpacity(0.5),
        ),
        itemBuilder: (context, index) {
          return _buildListTile(
              dataItem: this.vData[index]
          );
        },
      ),
    );
  }

  Widget buildAppBar() {
    final label = 'Product';

    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Select $label'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() => this.isNative = !isNative),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: SearchWidget(
            hintText: 'Search name',
            onChange: (value) {
              if(!value.isEmpty) {
                setState(() {
                  this.vData = onItemChanged(value);
                  this.vDataLength = this.vData.length;
                });
              }

            },
          ),
        ),
      ): null,
    );
  }

  Widget _buildListTile({
    @required Map dataItem
  }) {
    var productName = '';
    var obj = widget.productModel;
    if(obj != null) {
      productName = obj[ProductKey.name].toLowerCase();
    }

    return ListTile(
      onTap: () => selectProduct(dataItem),
      title: Text('${dataItem[ProductKey.name]}',
        style: TextStyle( color: dropColor, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      leading: _buildLeading(dataItem[ProductKey.url]),
      subtitle: Text('${dataItem[ProductKey.remark]}',
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
      ),
      trailing: (dataItem[ProductKey.name]).toLowerCase() == productName ? IconCheck() : null,
    );
  }


  Widget buildSearchWidget({
    @required String text,
    @required String hintText,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 40,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: InkWell(
              onTap: () {
                print('data search');
              },
              child: Icon(Icons.search, color: style.color)),
          suffixIcon: text.isNotEmpty ? GestureDetector(
            child: Icon(Icons.close, color: style.color),
            onTap: () {
              controller.clear();
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ) : null,
          hintText: hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: styleInput,
        onChanged: (value) {
          this.isItemChanged = true;
          if(value != null || value.trim() != '') {
            setState(() {
              this.vData = onItemChanged(value);
            });
          }
        },
      ),
    );
  }

  Widget _buildLeading(String url) {
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

  _fetchListItems() async {
    final data = await rootBundle.loadString('assets/json_data/product_list.json');
    Map valueMap = jsonDecode(data);
    var products = valueMap['products'];
    setState(() {
      this.vData = products;
      this.vDataTmp = this.vData;
      this.vDataLength = this.vData.length;
    });
    return vData;
  }

  void selectProduct(Map productModel) {
    Navigator.pop(context, productModel);
  }

  onItemChanged(String value) {
    var dataItems = vDataTmp.where((e) => e[ProductKey.name].toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }
}
