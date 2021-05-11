import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/import_add_key.dart';
import 'package:sale_management/share/model/key/package_product_key.dart';
import 'package:sale_management/share/model/key/product_key.dart';

class ImportItems extends StatefulWidget {
  final List<dynamic> vData;
  final ValueChanged<List<dynamic>> onChanged;
  ImportItems({
    @required this.vData,
    this.onChanged
  });

  @override
  _ImportItemsState createState() => _ImportItemsState();
}

class _ImportItemsState extends State<ImportItems> {
  Color _iconColor = Colors.purple[900];
  var i = 0;

  @override
  ImportItems get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    i = 0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          _widgetStack(context),
          drawerHandler(),
          if (widget.vData.length > 0 )
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 155,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                            children: <Widget>[
                              _buildDataTable(),
                            ]
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          // Container(
          //   height: 39,
          //   color: Colors.red,
          // )
        ],
      ),
    );
  }

  Widget _widgetStack(BuildContext context) {
    return Stack(
        children: [
          Container(
            width: double.infinity,
            height: 35.0,
            child: Center(
                child: Text("Import Items",
                    style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 20, color: _iconColor)
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
    );
  }

  drawerHandler() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 4,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffd9dbdb)
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text('No'),
          ),
          DataColumn(
            label: Text('Product'),
          ),
          DataColumn(
            label: Text('Package'),
          ),
          DataColumn(
            label: Text('Quantity'),
          ),
          DataColumn(
            label: Text('Total'),
          ),
          DataColumn(
            label: Text('Action'),
          ),
        ],
        rows: widget.vData.map((e) {
          i += 1;
          Map product = e[ImportAddKey.product];
          Map packageProduct = e[ImportAddKey.packageProduct];
          print('e: ${e[ImportAddKey.quantity]}');
          print('e: ${e[ImportAddKey.price]}');
          return DataRow(
              cells: <DataCell>[
                DataCell(Text(i.toString())),
                DataCell(
                    Row(
                        children: <Widget>[
                          _buildLeading(product[ProductKey.url].toString()),
                          SizedBox(width: 10),
                          Text(product[ProductKey.name].toString())
                        ]
                    )
                ),
                DataCell(Text(packageProduct[PackageProductKey.name].toString())),
                DataCell(Text(e[ImportAddKey.quantity].toString())),
                DataCell(Text(e[ImportAddKey.total].toString() + ' \$')),
                DataCell(_buildRemoveButton(e))
              ]
          );
        }

        ).toList()
    );
  }

  Widget _buildRemoveButton(Map<dynamic, dynamic> item) {
    return  Container(
      height: 35,
      width: 120,
      child: RaisedButton.icon(
          color: Colors.red,
          elevation: 4.0,
          onPressed: () {
            setState(() {
              widget.vData.remove(item);
              print('remove: ${widget.vData}');
              widget.onChanged(widget.vData);
            });
          },
          icon: FaIcon(FontAwesomeIcons.minusCircle,size: 20 , color: Colors.white,),
          label: Text('Remove',style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white))
      ),
    );
  }

  Widget _buildLeading(String url) {
    return Container(
      width: 35,
      height: 35,
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
