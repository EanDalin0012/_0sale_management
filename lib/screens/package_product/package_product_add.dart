import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/package_product/widgets/package_product_form_add.dart';

class PackageProductAdd extends StatefulWidget {
  PackageProductAdd({Key key}) : super(key: key);

  @override
  _PackageProductAddState createState() => _PackageProductAddState();

}

class _PackageProductAddState extends State<PackageProductAdd> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: PackageProductForm(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: Text('Package of Product', style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900]
    );
  }
}
