import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/package_product/package_product_add.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/screens/widgets/product_dropdown/product_page.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/components/show_dialog/show_dialog.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/package_product_key.dart';
import 'package:sale_management/share/model/key/product_key.dart';
import 'package:sale_management/share/model/package_product.dart';
import 'package:sale_management/share/services/load_data_local.dart';
import 'package:sale_management/share/utils/number_format.dart';

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

  TextEditingController _controller;
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
    this._fetchProductItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: <Widget>[
            if (this.items.length > 0 ) _buildBody() else CircularProgressLoading(),
            SizedBox(height: 70,)
          ],
        ),
        floatingActionButton: _floatingActionButton()
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Package of Product'),
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
              width: size.width - 70,
              margin: EdgeInsets.only(left: 18),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'Search name',
                onChange: (value) {
                  if(!value.isEmpty) {
                    setState(() {
                      items = onItemChanged(value);
                    });
                  }

                },
              ),
            ),
            // _buildFilterByProduct()
          ],
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

  Widget _buildFilterByProduct() {
    return Container(
      height: 40,
      // padding: EdgeInsets.only(
      //   right: 3
      // ),
      child: IconButton(
        icon: FaIcon(FontAwesomeIcons.filter,size: 25 , color: Colors.white,),
        tooltip: 'Increase volume by 10',
        onPressed: () async {
          final product = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage(
              productModel: this.product,
            )),
          );

          if (product == null) return;
          this.isItemChanged = false;
          this.isFilterByProduct = true;
          setState(() {
            this.product = product;
          });
        },
      ),
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
            Column(
              children: <Widget>[
                widget.packageProduct !=null && dataItem[PackageProductKey.id] == widget.packageProduct[PackageProductKey.id] ? _buildCheckIcon() : Container()
              ],
            ),

            // Column(
            //   children: <Widget>[
            //     _offsetPopup(dataItem),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckIcon() {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        left: 10
      ),
      child: Center(child: FaIcon(FontAwesomeIcons.checkCircle, size: 25 , color: Colors.deepPurple)),
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


  Widget _showDialog(PackageProductModel item) {
    ShowDialog.showDialogYesNo(
        buildContext: context,
        title: Text(item.name),
        content: Text('Do you want to delete package of product : '+item.name+'?'),
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

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PackageProductAdd()),
        );
      },
      tooltip: 'Increment',
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

  Container _container() {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      width: size.width,
      padding: EdgeInsets.only(
          left: 20,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child:  Text(
        'Package of Product List',
        style: containStyle,
      ),
    );
  }

  onItemChanged(String value) {
    var dataItems = itemsTmp.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }

  _fetchItems() async {
    print('item:');
    final data = await rootBundle.loadString(
        'assets/json_data/package_of_product_list.json');
    Map valueMap = jsonDecode(data);
    var dataItems = valueMap['packageProducts'];
    setState(() {
      this.items = dataItems;
      this.itemsTmp = this.items;
      print('\n data:${items.length}');
      var data = _doFilterByProduct(widget.product);
      this.items = data;
    });
    return this.items;
  }

  _fetchProductListItems() async {
    final data = await rootBundle.loadString('assets/json_data/product_list.json');
    Map valueMap = jsonDecode(data);
    var products = valueMap['products'];
    setState(() {
      this.vProductData = products;
      this.vProductDataTmp = this.vProductData;
    });
    return vProductData;
  }

  Future<void> _fetchProductItems() async {
    await LoadLocalData.fetchProductItems().then((value) {
      this.productItems = value;
    });

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

  _doFilterByProduct(Map product) {
    var dataItems = itemsTmp.where((e) => e[PackageProductKey.id].toString().contains(product[ProductKey.id].toString())).toList();
    return dataItems;
  }

  void selectPackageProduct(Map packageProductModel) {
    Navigator.pop(context, packageProductModel);
  }

}
