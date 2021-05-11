import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/sale/widgets/sale_add_form.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/sale/widgets/sale_items.dart';

class SaleAddScreen extends StatefulWidget {
  @override
  _PackageProductAddState createState() => _PackageProductAddState();
}

class _PackageProductAddState extends State<SaleAddScreen> {

  var cartArrowDownCount = 0 ;
  List<dynamic> vData = [];
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: SaleAddForm(
          onChange: (items) {
            setState(() {
              this.vData = items;
              this.cartArrowDownCount = this.vData.length;
            });
          })
      ),
    );
  }


  AppBar _appBar() {
    return AppBar(
        title: Text('Sale', style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900],
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              _showModelSheet();
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


  Container _showModelSheet() {
    var orientation = MediaQuery.of(context).orientation;
    double height = (MediaQuery.of(context).copyWith().size.height * 0.95);
    setState(() {
      if(orientation != Orientation.portrait){
        height = MediaQuery.of(context).copyWith().size.height * 0.5;
      }
    });

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext builder) {
          return Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.deepPurpleAccent.withOpacity(0.5)
            ),
              child: SaleItems(
                vData: this.vData,
                onChanged: (vChangeData) {
                  setState(() {
                    this.vData = vChangeData;
                    this.cartArrowDownCount = this.vData.length;
                  });
                },
              ),
          );
        });
  }

}
