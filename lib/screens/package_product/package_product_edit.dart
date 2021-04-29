import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/widgets/product_dropdown/product_dropdown.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/catgory.dart';
import 'package:sale_management/share/model/product.dart';
import 'package:sale_management/share/model/package_product.dart';
import 'package:sale_management/share/services/load_data_local.dart';

class PackageProductEdit extends StatefulWidget {

  final PackageProductModel packageProduct;
  PackageProductEdit({
    @required this.packageProduct
  });

  @override
  _PackageProductAddState createState() => _PackageProductAddState();
}

class _PackageProductAddState extends State<PackageProductEdit> {
  _PackageProductAddState() {
    _fetchProductItems();
  }

  var borderColorsTextField = Colors.deepPurple;
  var labelStyle = TextStyle(fontSize: 20, color: Colors.deepPurple, fontFamily: fontFamilyDefault);
  var hintStyle = TextStyle(fontFamily: fontFamilyDefault);
  var nameValueController = new TextEditingController();
  var remarkValueController = new TextEditingController();
  var quantityValueController = new TextEditingController();
  var priceValueController = new TextEditingController();

  var textValue = 'Select Product';
  var colorValue = Colors.deepPurple;
  Map<String, Object> dropdownValue;
  List<ProductModel> productItems = [];
  ProductModel product;
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    nameValueController.text = widget.packageProduct.name;
    remarkValueController.text = widget.packageProduct.remark;
    quantityValueController.text = widget.packageProduct.quantity.toString();
    priceValueController.text    = widget.packageProduct.price.toString();

    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: <Widget>[
          _container(),
          _body(),
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _save();
                },
                child: Container(
                  width: size.width,
                  height: 45,
                  color: Colors.red,
                  // margin: EdgeInsets.only(
                  //   left: 5,
                  //   right: 5
                  // ),
                  child: Center(child: Text('SAVE', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  AppBar _appBar() {
    return AppBar(
        title: Text('Package of Product', style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900]
    );
  }

  Container _container() {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      padding: EdgeInsets.only(
          left: 10,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              'Add New Package of Product',
              style: containStyle
          ),
        ],
      ),
    );
  }

  Expanded _body() {
    return Expanded(
        child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10),
            physics: ClampingScrollPhysics(),
            child: Column(
                children: <Widget>[
                  _nameField(),
                  Container(
                    margin: EdgeInsets.only(
                        left: 10,
                        right: 10
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: colorValue, width: 1.5)
                    ),
                    child: ProductDropdown(
                      color: colorValue,
                      product: this.product,
                      onChanged: (value) {
                        print('product change event work: ${value.toString()}');
                      },
                    ),
                  ),
                  _quantityField(),
                  _priceField(),
                  _remarkField()
                ])
        )
    );
  }

  Padding _nameField() {
    return Padding(
      padding: EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10,
          bottom: 10
      ),
      child: TextField(
        controller: nameValueController,
        decoration: InputDecoration(
            hintText: 'Enter category name',
            labelText: 'Name',
            // helperText: 'Category Name',
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            // helperStyle: TextStyle(
            //     color: Colors.blueGrey,
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'roboto'
            // ),
            // border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColorsTextField,
                    width: 1.5,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.5,
                    style: BorderStyle.solid
                )
            ),
            prefixIcon: Icon(
              Icons.info_outline,
              color: Colors.black54,
            )

        ),
      ),
    );
  }

  Padding _quantityField() {
    return Padding(
      padding: EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10,
      ),
      child: TextField(
        controller: quantityValueController,
        decoration: InputDecoration(
            hintText: 'Enter quantity',
            labelText: 'Quantity',
            // helperText: 'Remark',
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            // helperStyle: TextStyle(
            //     color: Colors.blueGrey,
            //     fontWeight: FontWeight.bold
            // ),
            // border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColorsTextField,
                    width: 1.5,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.5,
                    style: BorderStyle.solid
                )
            ),
            prefixIcon: Icon(
              Icons.info_outline,
              color: Colors.black54,
            )

        ),
      ),
    );
  }

  Padding _priceField() {
    return Padding(
      padding: EdgeInsets.only(
        right: 10,
        left: 10,
        top: 10,
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: priceValueController,
        decoration: InputDecoration(
            hintText: 'Enter price',
            labelText: 'Price',
            // helperText: 'Remark',
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            // helperStyle: TextStyle(
            //     color: Colors.blueGrey,
            //     fontWeight: FontWeight.bold
            // ),
            // border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColorsTextField,
                    width: 1.5,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.5,
                    style: BorderStyle.solid
                )
            ),
            prefixIcon: Icon(
              Icons.info_outline,
              color: Colors.black54,
            )

        ),
      ),
    );
  }


  Padding _remarkField() {
    return Padding(
      padding: EdgeInsets.only(
        right: 10,
        left: 10,
        top: 10,
      ),
      child: TextField(
        controller: remarkValueController,
        decoration: InputDecoration(
            hintText: 'Enter remark',
            labelText: 'Remark',
            // helperText: 'Remark',
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            // helperStyle: TextStyle(
            //     color: Colors.blueGrey,
            //     fontWeight: FontWeight.bold
            // ),
            // border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColorsTextField,
                    width: 1.5,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.5,
                    style: BorderStyle.solid
                )
            ),
            prefixIcon: Icon(
              Icons.edit,
              color: Colors.black54,
            )

        ),
      ),
    );
  }

  _save() {
    var categoryModel = new CategoryModel(nameValueController.text, remarkValueController.text);
    print(categoryModel.toString());
  }


  Widget buildListTile({
    @required String title,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }

  Widget buildCountryPicker({
    @required String title,
    @required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );

  Future<void> _fetchProductItems() async {
    await LoadLocalData.fetchProductItems().then((value) {
      this.productItems = value;
      if(widget.packageProduct.productId > 0 && widget.packageProduct.productId != null) {
        setState(() {
          product = _searchProductById(widget.packageProduct.productId);
          print('product: ${product}');
        });
      }
    });

  }

  ProductModel _searchProductById(int productId) {
    if(this.productItems.length > 0) {
      for(ProductModel p in productItems) {
        if(p.id == productId) {
          return p;
        }
      }
    }
  }

}
