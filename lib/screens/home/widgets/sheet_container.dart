import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/category/category.dart';
import 'package:sale_management/screens/package_product/package_product.dart';
import 'package:sale_management/screens/product/product.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/member/member.dart';
import 'package:sale_management/screens/vendor/vendor.dart';

class SheetContainer extends StatefulWidget {
  final BuildContext context;
  SheetContainer(this.context);
  @override
  _SheetContainerState createState() => _SheetContainerState();
}

class _SheetContainerState extends State<SheetContainer> {
  var colorContain = Color(0xffd9dbdb).withOpacity(0.9);
  Color _iconColor = Colors.purple[900];
  double _iconSize = 25;
  double wContainer = 60;
  double hContainer = 50;
  BoxBorder border = Border.all(color: Colors.blueGrey[100].withOpacity(0.2), width: 4);
  var textStyle = TextStyle(color: Colors.purple[900],fontSize: 15,fontWeight: FontWeight.w700, fontFamily: 'roboto');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = (size.width / 3) - 25;
    double h = w - 20;
    return Container(
      color: Color(0xFF737373),
      child: Container(
          padding: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Color(0xfff1f1f1)
          ),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 35.0,
                          child: Center(
                              child: Text("Menu",
                                style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 20)
                              ) // Your desired title
                          ),
                        ),
                        Positioned(
                            left: 0.0,
                            top: 0.0,
                            child: IconButton(
                                icon: FaIcon(FontAwesomeIcons.arrowLeft,size: 20 , color: _iconColor,), // Your desired icon
                                onPressed: (){
                                  Navigator.of(context).pop();
                                }
                            )
                        )
                      ]
                  ),
                  drawerHandler(),
                  item1(w,h),
                  SizedBox(height: 20,),
                  item0(w, h),
                  SizedBox(height: 20,),
                  item2(w, h),
                ]
            ),
          )
      ),
    );
  }

  drawerHandler() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 4,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffd9dbdb)
      ),
    );
  }

  item2(double w, double h) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductScreen()),
            );
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                      borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.productHunt,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Product',style: textStyle),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print('Vendor Click');
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                      borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.vimeo,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Vendor',style: textStyle),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print('Vendor Click');
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                      borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.vimeo,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Vendor',style: textStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  item1(double w, double h) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  CategoryScreen()
              ),
            );

          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.cuttlefish,size: _iconSize , color: _iconColor,)),
                ),
                SizedBox(height: 5,),
                Text('Category',style: textStyle),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductScreen()),
            );
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                    border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.productHunt,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Product',style: textStyle),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(widget.context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PackageProductScreen()
              ),
            );

          },
          child: Container(
            width: w,
            height: h + 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                      borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.cuttlefish,size: _iconSize , color: _iconColor,)),
                ),
                SizedBox(height: 5,),
                Text('Package',style: textStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  item0(double w, double h) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MemberScreen()),
            );
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                    border: border
                  ),
                  child:Center(child: FaIcon(FontAwesomeIcons.users,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Member',style: textStyle),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VendorScreen()),
            );

          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                    border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.vimeo,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Vendor',style: textStyle),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {

          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                    border: border

                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.database,size: _iconSize, color: _iconColor,)),
                ),
                SizedBox(height: 5,),
                Text('Stock',style: textStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pop() {
    Navigator.pop(widget.context);
  }

}
