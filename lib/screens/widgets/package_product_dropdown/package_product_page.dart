import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/share/model/key/package_product_key.dart';
import 'package:sale_management/share/model/key/product_key.dart';
import 'package:sale_management/share/utils/number_format.dart';
import 'package:sale_management/screens/widgets/icon_check/icon_check.dart';

class PackageProductPage extends StatefulWidget {

  final Map packageProduct;
  final Map product;
  const PackageProductPage({
    Key key,
    this.packageProduct,
    this.product
  }) : super(key: key);

  @override
  _PackageProductScreenState createState() => _PackageProductScreenState();
}

class _PackageProductScreenState extends State<PackageProductPage> {

  var controller = TextEditingController();
  var isItemChanged = false;
  var isFilterByProduct = false;
  var isNative = false;
  var isSearch = false;
  var text = '';
  Size size ;
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);

  var menuStyle = TextStyle( color: Colors.purple[900], fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);

  List<dynamic> items = [];
  List<dynamic> itemsTmp = [];
  List<dynamic> productItems = [];

  List<dynamic> vProductData = [];
  List<dynamic> vProductDataTmp = [];

  Map product;

  var itemsLength = 0;

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
        body: GestureDetector(
          onTap: () {
            KeyboardUtil.hideKeyboard(context);
          },
          child: Column(
            children: <Widget>[
              if (this.items.length > 0 ) _buildBody() else CircularProgressLoading(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
            ],
          ),
        ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Package of Product'),
      actions: [
        IconButton(
          icon: Icon(this.isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            if(this.isNative == true) {
              this.items = this.itemsTmp;
            }
            this.isNative = !isNative;
            this.isItemChanged = false;
            this.isFilterByProduct = false;
          }),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: SearchWidget(
            hintText: 'Search name',
            onChange: (value) {
              setState(() {
                items = onItemChanged(value);
              });
            },
          ),
        ),
      ): null,
    );
  }

  Widget _buildBody () {
    return Expanded(
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.purple[900].withOpacity(0.5),
          ),
          itemBuilder: (context, index) {
            return _buildListTile(
                dataItem: items[index]
            );
          },
        )
      );
  }

  Widget _buildListTile({
    @required Map dataItem
  }) {
    return ListTile(
      onTap: () => selectPackageProduct(dataItem),
      title: Text( '${dataItem[PackageProductKey.name]}',
        style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      leading: _buildLeading(dataItem[PackageProductKey.id]),
      subtitle: Text(
        FormatNumber.usdFormat2Digit(dataItem[PackageProductKey.price].toString()).toString()+' \$,'+dataItem[PackageProductKey.remark],
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
                      dataItem[PackageProductKey.quantity].toString(),
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
            if (widget.packageProduct !=null && dataItem[PackageProductKey.id] == widget.packageProduct[PackageProductKey.id])
              Center(child: IconCheck()) else Container()
          ],
        ),
      ),
    );
  }

  Widget _buildLeading(int productId) {
    var url = _searchProductById(productId);
    if(url == null) {
      url = 'https://icons-for-free.com/iconfiles/png/512/part+1+p-1320568343314317876.png';
    }
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

  onItemChanged(String value) {
    var dataItems = itemsTmp.where((e) => e[PackageProductKey.name].toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }

  _fetchItems() async {
    final data = await rootBundle.loadString(
        'assets/json_data/package_of_product_list.json');
    Map valueMap = jsonDecode(data);
    var dataItems = valueMap['packageProducts'];
    var items = dataItems.where((e) => e[PackageProductKey.id].toString().contains(widget.product[ProductKey.id].toString())).toList();
    setState(() {
      this.items = items;
      this.itemsTmp = this.items;
    });
    return this.items;
  }


  String _searchProductById(int productId) {
    if(this.productItems.length > 0) {
      for(Map p in productItems) {
        if(int.parse(p[ProductKey.id].toString()) == productId) {
          return p[ProductKey.url];
        }
      }
    }
  }

  void selectPackageProduct(Map packageProductModel) {
    Navigator.pop(context, packageProductModel);
  }

}
