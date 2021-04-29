import 'package:flutter/material.dart';
import 'package:sale_management/share/model/package_product.dart';
import 'package:sale_management/screens/widgets/product_dropdown/FlagImageWidget.dart';
import 'package:sale_management/screens/widgets/package_product_dropdown/package_product_page.dart';
import 'package:sale_management/share/model/product.dart';

class PackageProductDropdown extends StatefulWidget {
  final ValueChanged<PackageProductModel> onChanged;
  final Color color;
  final ProductModel product;
  final PackageProductModel packageProduct;

  PackageProductDropdown({
    this.color,
    @required this.product,
    this.packageProduct,
    this.onChanged
  });
  @override
  _ProductDropdownState createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<PackageProductDropdown> {

  PackageProductModel _packageProductModel;
  List<ProductModel> productItems = [];
  var url = 'https://icons-for-free.com/iconfiles/png/512/part+1+p-1320568343314317876.png';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    this._packageProductModel = widget.packageProduct;
    if(widget.product != null) {
      setState(() {
        this.url = widget.product.url;
      });
    }
    return  Container(
      child: buildSingleProduct(),
    );
  }

  Widget buildSingleProduct() {
    final onTap = () async {
      final product = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PackageProductPage(
          product: widget.product,
          packageProduct: widget.packageProduct,
        )),
      );

      if (product == null) return;
      setState(() {
        this._packageProductModel = product;
      });
      widget.onChanged(product);
    };

    return buildCountryPicker(
      title: 'Select Country',
      child: _packageProductModel == null ? buildListTile(
          title: 'Select Package Product',
          leading: widget.product != null ? FlagImageWidget(
            width: 40,
            height: 40,
            url: url,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(60)),
              border: Border.all(color: Colors.grey, width: 0),
            ),
          ) : Icon(
            Icons.info_outline,
            color: Colors.black54,
          ),
          onTap: onTap
      ) : buildListTile(
        title: _packageProductModel.name,
        leading: FlagImageWidget(
          width: 40,
          height: 40,
          url: url,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            border: Border.all(color: Colors.grey, width: 0),
          ),
        ),
        onTap: onTap,
      ),
    );
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
        style: TextStyle(color: widget.color, fontSize: 18),
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
          // Text(
          //   title,
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // const SizedBox(height: 12),
          Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              child: child),
        ],
      );

  Widget buildLeading(String url) {
    return Container(
      width: 40,
      height: 40,
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

}
