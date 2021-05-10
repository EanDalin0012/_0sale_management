import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/import/widget/add_import_form.dart';

class AddImportScreen extends StatefulWidget {
  AddImportScreen({Key key}):super(key: key);
  @override
  _AddImportScreenState createState() => _AddImportScreenState();
}

class _AddImportScreenState extends State<AddImportScreen> {
  var cartArrowDownCount = 0;
  Size size;
  List<dynamic> vData = [];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: AddImportForm(
          onAddChange: (itemCount) {
            setState(() {
              this.cartArrowDownCount = itemCount;
            });
          },
        )
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: Text('Import', style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900],
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              // _showModelSheet();
            },
            child: Container(
              height: 80,
              width: 55,
              child: Stack(
                children: <Widget>[
                  Center(child:  FaIcon(FontAwesomeIcons.cartArrowDown,size: 25 , color: Colors.white,),),
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(
                        top: 5,
                        left: 30
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(child: Text(cartArrowDownCount.toString(), style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800))),
                  ),
                ],
              ),
            ),
          ),
        ]
    );
  }


}
