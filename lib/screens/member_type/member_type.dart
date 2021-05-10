import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/share/components/show_dialog/show_dialog.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/vendor_key.dart';

class MemberType extends StatefulWidget {
  @override
  _MemberTypeState createState() => _MemberTypeState();
}

class _MemberTypeState extends State<MemberType> {
  bool isSearch = false;
  TextEditingController _controller;
  List<dynamic> categories = [];
  var menuStyle = TextStyle( color: Colors.purple[900], fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Column(
          children: <Widget>[
            isSearch ? _containerSearch() : _container(),
            _mainTransactionBody()
          ],
        ),
        floatingActionButton: _floatingActionButton()
    );
  }

  _save() async {
    // if (_controller.text.isEmpty) return;
    // FocusScope.of(context).requestFocus(FocusNode());
    // setState(() {
    //   messages.insert(0, Message(rand.nextInt(2), _controller.text));
    //   _controller.clear();
    // });
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Category', style: appBarStyle,),
      backgroundColor: Colors.purple[900],
    );
  }

  Container _containerSearch() {
    return Container(
      height: 60,
      // margin: const EdgeInsets.symmetric(
      //   vertical: 8.0,
      //   horizontal: 16.0,
      // ),
      decoration: BoxDecoration(
          color: Colors.grey.shade200
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: _controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: "Search here"),
              onEditingComplete: _save,
            ),
          ),
        ],
      ),
    );
  }

  Container _container() {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      padding: EdgeInsets.only(
          left: 20,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Category List',
            style: containStyle,
          ),
          InkWell(
            onTap: () {
              print(isSearch);

              setState(() {
                this.isSearch = true;
              });
            },
            child: FaIcon(FontAwesomeIcons.search,size: 15 , color: Colors.blueGrey,),
          ),
        ],
      ),
    );
  }

  Expanded _mainTransactionBody() {
    return Expanded(
        child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10),
            physics: ClampingScrollPhysics(),
            child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  print(this.isSearch);
                  setState(() {
                    this.isSearch = false;
                  });
                },
                child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) => ListTile(
                        title: Text( categories[index].name,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: fontFamilyDefault
                          ),
                        ),
                        subtitle: Text(
                          'Remark: '+categories[index].remark,
                          style: TextStyle( color: primaryColor.withOpacity(0.8),fontSize: 12,fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault),
                        ),
                        trailing: Column(
                          children: <Widget>[
                            _offsetPopup(categories[index]),
                          ],
                        )
                    )
                )

            )
        )
    );
  }

  Widget _offsetPopup(Map categoryModel) => PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
          value: 2,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.edit,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                "Edit",
                style: menuStyle,
              ),
            ],
          )
      ),
      PopupMenuItem(
          value: 3,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.trash,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                "Delete",
                style: menuStyle,
              ),
            ],
          )
      ),
    ],
    icon: FaIcon(FontAwesomeIcons.ellipsisV,size: 20,color: Colors.black),
    offset: Offset(0, 45),
    onSelected: (value) {
      if(value == 1) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => VendorViewScreen(vendorModel)),
        // );
      } else if(value == 2) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => EditCategoryScreen(categoryModel)),
        // );
      } else if (value == 3) {
        _showDialog(categoryModel);
      }
    },
  );

  Widget _showDialog(Map _vendorModel) {
    ShowDialog.showDialogYesNo(
        buildContext: context,
        title: Text(_vendorModel[VendorKey.name]),
        content: Text('Do you want to delete category : '+_vendorModel[VendorKey.name]+'?'),
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => AddNewCategoryScreen()),
        // );
      },
      tooltip: 'Increment',
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }
}
