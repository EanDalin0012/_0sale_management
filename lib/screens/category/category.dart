import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/category/add_category.dart';
import 'package:sale_management/screens/category/edit_category.dart';
import 'package:sale_management/screens/home/Home.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/share/components/show_dialog/show_dialog.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/category_key.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<CategoryScreen> {

  var isNative = false;
  Size size ;
  int vDataLength = 0;
  List<dynamic> vData = [];

  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  bool isSearch = false;
  TextEditingController _controller;
  var menuStyle = TextStyle( color: Colors.purple[900], fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop:  () async {
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Column(
              children: <Widget>[
                isSearch ? _containerSearch() : _container(),
                _mainTransactionBody()
              ],
            ),
          floatingActionButton: _floatingActionButton()
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Category'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            this.isNative = !isNative;
            // this.isItemChanged = false;
            // this.isFilterByProduct = false;
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
              width: size.width - 40,
              height: 65,
              margin: EdgeInsets.only(left: 18),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'Search name',
                onChange: (value) {
                  print('value ${value}');
                },
              ),
            ),
            // _buildFilterByProduct()
          ],
        ),
      ): null,
    );
  }

  Container _containerSearch() {
    return Container(
      height: 60,
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
            child: Text(this.vDataLength.toString(),style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault)),
          ),
        ],
      ),
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
                  itemCount: vDataLength,
                  itemBuilder: (context, index) => ListTile(
                    title: Text( this.vData[index][CategoryKey.name],
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: fontFamilyDefault
                      ),
                    ),
                    subtitle: Text(
                      this.vData[index][CategoryKey.remark],
                      style: TextStyle( color: primaryColor.withOpacity(0.8),fontSize: 12,fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault),
                    ),
                      trailing: Column(
                        children: <Widget>[
                          _offsetPopup(this.vData[index]),
                        ],
                      )
                  )
                )

          )
        )
    );
  }

  Widget _offsetPopup(Map category) => PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
          value: 0,
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
          value: 1,
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
      if(value == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditCategoryScreen(category: category)),
        );
      } else if (value == 1) {
        _showDialog(category);
      }
    },
  );

  Widget _showDialog(Map category) {
    return ShowDialog.showDialogYesNo(
        buildContext: context,
        title: Text(category[CategoryKey.name]),
        content: Text('Do you want to delete category : '+category[CategoryKey.name]+'?'),
        btnYes: 'Yes',
        onPressedYes: () {
          print('onPressedBntRight');
        },
        btnNo: 'No',
        onPressedNo: () {
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
          MaterialPageRoute(builder: (context) => AddNewCategoryScreen()),
        );
      },
      tooltip: 'Increment',
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/category_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['categoryList'];
      this.vDataLength = this.vData.length;
      print('${this.vData}');
    });
    return this.vData;
  }
}
