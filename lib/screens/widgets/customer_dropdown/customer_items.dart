import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/share/constant/constantcolor.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/m_key.dart';

class CustomerItems extends StatefulWidget {
  final Color color;
  Map vCustomer;
  CustomerItems({
    this.color,
    this.vCustomer
  });

  @override
  _CustomerItemsState createState() => _CustomerItemsState();
}

class _CustomerItemsState extends State<CustomerItems> {
  Size size ;
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
  var controller = TextEditingController();
  List<dynamic> vData = [];
  int itemLength = 0;
  var isNative = false;
  var _controller = ScrollController();

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);//the listener for up and down.
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: <Widget>[
            _container(),
            if(this.vData.length > 0 )
              SingleChildScrollView(
                  child: Container(
                      height: size.height - 200,
                      child: _buildBody())
              ),
          ],
        ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Customer'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            // this.isNative = !isNative;
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
              width: size.width,
              child: _buildSearchWidget(
                text: controller.text,
                // onChanged: (text) => setState(() => this.text = text),
                hintText: 'Search by name', onTap: () {  },
              ),
            ),
            // _buildFilterByProduct()
          ],
        ),
      ): null,
    );
  }

  Container _container() {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      width: size.width,
      padding: EdgeInsets.only(
          left: 20,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              'Customer',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault)
          ),
          Text(this.itemLength.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault),)
        ],
      ),
    );
  }

  Widget _buildBody () {
    print('${this.vData}');
    return ListView.separated(
          itemCount: vData.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.purple[900].withOpacity(0.5),
          ),
        itemBuilder: (context, index) => _buildListTile(customer: vData[index])
        //     ListTile(
        //      onTap: () => selectedItem(vCustomer: vData[index]),
        //       title: Text(
        //      vData[index][CustomerKey.customerName].toString(),
        //       style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),),
        //     subtitle: Text(
        //     'Phone: '+vData[index][CustomerKey.phone].toString(),
        //     style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
        //     ),
        //       trailing: widget.vCustomer != null && vData[index][CustomerKey.id] == widget.vCustomer[CustomerKey.id] ? FaIcon(FontAwesomeIcons.checkCircle, size: 25 , color: Colors.deepPurple): null,
        // ),

        );
  }

  Widget _buildListTile({
    @required Map customer
  }) {
    print('customer ${customer}');
    return ListTile(
      onTap: () => selectedItem(vCustomer: customer),
      title: Text( customer[CustomerKey.customerName].toString(),
        style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      subtitle: Text(
        'Phone: '+customer[CustomerKey.phone].toString(),
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
      ),
      trailing: widget.vCustomer != null && customer[CustomerKey.id] == widget.vCustomer[CustomerKey.id] ? FaIcon(FontAwesomeIcons.checkCircle, size: 25 , color: Colors.deepPurple): null,
    );
  }

  Widget _buildSearchWidget({
    @required String text,
    @required String hintText,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    final styleActive = TextStyle(color: Colors.black, fontSize: 15);
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
          print('value : ${value}');
          // if(value != null || value.trim() != '') {
          //   this.isItemChanged = true;
          //   if(value != null || value.trim() != '') {
          //     setState(() {
          //       items = onItemChanged(value);
          //     });
          //   }
          // }
        },
      ),
    );
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
  }


  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/customer_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['customers'];
      this.itemLength = this.vData.length;
    });
    return this.vData;
  }

  void selectedItem({
    @required Map vCustomer
  }) {
    Navigator.pop(context, vCustomer);
  }

}
