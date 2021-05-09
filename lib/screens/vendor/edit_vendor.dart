import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/vendor/widget/edit_vendor_form.dart';

class EditVendorScreen extends StatefulWidget {

  final Map vendor;
  EditVendorScreen({Key key,this.vendor}):super(key: key);

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<EditVendorScreen> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          foregroundColor: Colors.purple[900],
          title: Text("Vendor"),
        ),
        body: SafeArea(
          child: EditVendorForm(vVendor: widget.vendor),
        )
    );
  }

}
