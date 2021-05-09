import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/circular_progress_loading.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/model/key/category_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/share/constant/text_style.dart';

class CategoryDropdownPage extends StatefulWidget {
  final Map vData;

  const CategoryDropdownPage({Key key, this.vData}) : super(key: key);

  @override
  _CategoryDropdownPageState createState() => _CategoryDropdownPageState();
}

class _CategoryDropdownPageState extends State<CategoryDropdownPage> {

  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
  var isNative = false;
  var text = '';
  var controller = TextEditingController();
  var isItemChanged = false;

  List<dynamic> vData = [];
  List<dynamic> vDataTmp = [];
  var vDataLength = 0;

  @override
  void initState() {
    super.initState();
    this._fetchListItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          if (vDataLength > 0 ) _buildBody() else CircularProgressLoading(),
        ],
      )
    );
  }


  Widget _buildAppBar() {
    final label = 'Choose Category';

    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Select $label'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() => this.isNative = !isNative),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  buildSearchWidget(
          text: text,
          // onChanged: (text) => setState(() => this.text = text),
          hintText: 'Search $label',
        ),
      ): null,
    );
  }

  Widget _buildBody () {
    return Expanded(
        child:  ListView.separated(
          itemCount: vDataLength,
          separatorBuilder: (context, index) => Divider(
            color: Colors.purple[900].withOpacity(0.5),
          ),
          itemBuilder: (context, index) {
            return _buildListTile(
                dataItem: this.vData[index]
            );
          },
        )
    );
  }

  Widget _buildListTile({
    @required Map dataItem
  }) {
    var categoryID = '';
    var obj = widget.vData[CategoryKey.id];
    if(obj != null) {
      categoryID = obj;
    }

    return ListTile(
      onTap: () => onSelectedItem(dataItem),
      title: Text( dataItem[CategoryKey.name],
        style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      subtitle: Text(
          dataItem[CategoryKey.remark],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
      ),
      trailing: widget.vData[CategoryKey.id] == dataItem[CategoryKey.id]? _buildCheckIcon() : null,
    );
  }

  Widget buildSearchWidget({
    @required String text,
    @required String hintText,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 40,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: InkWell(
              onTap: () {
                print('data search');
              },
              child: Icon(Icons.search, color: style.color)),
          suffixIcon: text.isNotEmpty ? GestureDetector(
            child: Icon(Icons.close, color: style.color),
            onTap: () {
              controller.clear();
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ) : null,
          hintText: hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: styleInput,
        onChanged: (value) {
          this.isItemChanged = true;
          if(value != null || value.trim() != '') {
            setState(() {
              vData = onItemChanged(value);
            });
          }
        },
      ),
    );
  }

  Widget _buildCheckIcon() {
    return Container(
      margin: EdgeInsets.only(
          left: 100
      ),
      child: Center(child: FaIcon(FontAwesomeIcons.checkCircle, size: 25 , color: Colors.deepPurple)),
    );
  }

  void onSelectedItem(Map data) {
    Navigator.pop(context, data);
  }

  onItemChanged(String value) {
    var dataItems = vDataTmp.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }

  _fetchListItems() async {
    final data = await rootBundle.loadString('assets/json_data/category_list.json');
    Map mapItems = jsonDecode(data);
    print('${mapItems}');
    setState(() {
      this.vData = mapItems['categoryList'];
      this.vDataLength = this.vData.length;
    });
    return this.vData;
  }


}
