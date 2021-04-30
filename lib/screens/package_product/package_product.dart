import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/screens/widgets/product_dropdown/product_page.dart';
import 'package:sale_management/share/components/show_dialog/show_dialog.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/share/model/product.dart';
import 'package:sale_management/share/model/package_product.dart';
import 'package:sale_management/share/services/load_data_local.dart';
import 'package:sale_management/share/utils/number_format.dart';
import 'package:sale_management/screens/package_product/package_product_edit.dart';
import 'package:sale_management/screens/package_product/package_product_add.dart';

class PackageProductScreen extends StatefulWidget {
  @override
  _PackageProductScreenState createState() => _PackageProductScreenState();
}

class _PackageProductScreenState extends State<PackageProductScreen> {
  var controller = TextEditingController();
  var isItemChanged = false;
  var isFilterByProduct = false;
  var isNative = false;
  var isSearch = false;
  var text = '';
  Size size ;
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
  var menuStyle = TextStyle( color: Colors.purple[900], fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);

  List<PackageProductModel> items = [];
  List<PackageProductModel> itemsTmp = [];
  List<ProductModel> productItems = [];
  ProductModel product;
  int itemLength = 0;


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
        body: InkWell(
          onTap: () {
            KeyboardUtil.hideKeyboard(context);
          },
          child: Column(
            children: <Widget>[
              _container(),
              if (items.length > 0 ) _buildBody() else CircularProgressLoading(),
              SizedBox(height: 60,)
            ],
          ),
        ),
        floatingActionButton: _floatingActionButton()
    );
  }

  Widget _buildAppBar() {
    return AppBar(
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
                width: size.width - 60,
                height: 65,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: _buildSearchField()
            ),
            _buildFilterByProduct()
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
            );},
        )
    );
  }

  Widget _buildFilterByProduct() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 12),
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
            this.items = this._doFilterByProduct(this.product);
          });
        },
      ),
    );
  }

  TextFormField _buildSearchField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white, fontSize: 20),
      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        this.isItemChanged = true;
        if(value != null || value.trim() != '') {
          this.isItemChanged = true;
          if(value != null || value.trim() != '') {
            setState(() {
              items = onItemChanged(value);
            });
          }
        }
      },
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.white, fontSize: 20),
        hintText: "Enter your email",
        hintStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.white54,
            ),
          ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.white54,
            ),
        ),
        prefixIcon: _buildSvgSurfFixIcon(svgPaddingLeft: 15, svgIcon: "assets/icons/Search Icon.svg")
      ),
    );
  }


  Widget _offsetPopup(PackageProductModel item) => PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
          value: 0,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.edit,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                'Edit',
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              PackageProductEdit(packageProduct: item)
          ),
        );
      } else if (value == 1) {
        _showDialog(item);
      }
    },
  );

  Widget _buildListTile( {
    @required PackageProductModel dataItem
  }) {
    return ListTile(
        title: Text( dataItem.name,
          style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
        ),
        leading: _buildLeading(dataItem.productId),
      subtitle: Text(
        FormatNumber.usdFormat2Digit(dataItem.price.toString()).toString()+' \$,'+dataItem.remark,
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
                      dataItem.quantity.toString(),
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
    return ShowDialog.showDialogYesNo(
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
    this.itemLength = this.items.length;
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
            'Package of Product List',
            style: containStyle,
          ),
          Text(this.itemLength.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault),)
        ],
      ),
    );
  }

  Widget _buildSvgSurfFixIcon( {
    double svgPaddingLeft,
    String svgIcon
  }) {
    double left = 0;
    if(svgPaddingLeft != null) {
      left = svgPaddingLeft;
    }
    return Padding(
      padding: EdgeInsets.fromLTRB( left,10,10,10),
      child: SvgPicture.asset(
        svgIcon,
        color: Colors.white,
        height: getProportionateScreenWidth(19)
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }


  onItemChanged(String value) {
    var dataItems = itemsTmp.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }

  _fetchItems() async {
      final data = await rootBundle.loadString(
          'assets/json_data/package_of_product_list.json');
      Map valueMap = jsonDecode(data);
      var dataItems = valueMap['packageProducts'];
      var arrObjs = dataItems.map<PackageProductModel>((json) {
        return PackageProductModel.fromJson(json);
      }).toList();
      setState(() {
        this.items = arrObjs;
        this.itemsTmp = this.items;
      });
      _fetchProductItems();
      return this.items;

  }

  _fetchProductItems() {
      LoadLocalData.fetchProductItems().then((value) {
        productItems = value;
      });
  }

  String _searchProductById(int productId) {
    if(this.productItems.length > 0) {
      for(ProductModel p in productItems) {
          if(p.id == productId) {
            return p.url;
          }
      }
    }
  }

  _doFilterByProduct(ProductModel product) {
    var dataItems = itemsTmp.where((e) => e.productId.toString().contains(product.id.toString())).toList();
    return dataItems;
  }

}
