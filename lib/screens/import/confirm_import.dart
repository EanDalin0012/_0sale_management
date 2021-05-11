import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/import/import_success_screen.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/import_add_key.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/model/key/package_product_key.dart';
import 'package:sale_management/share/model/key/product_key.dart';
import 'package:sale_management/share/utils/number_format.dart';

class ConfirmImport extends StatefulWidget {
  final List<dynamic> vData;
  ConfirmImport({
    @required this.vData
  });
  @override
  _ConfirmImportState createState() => _ConfirmImportState();
}

class _ConfirmImportState extends State<ConfirmImport> {
  var colorValue = Colors.deepPurple;
  Size size;
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
  var remarkController = new TextEditingController();
  var i = 0;
  double pay = 0.0;
  double vPay = 0.0;
  Map vCustomer;
  var total = 0.0;

  @override
  void initState() {
    super.initState();
    vPayFunction();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    this.i = 0;
    this.total = 0;
    if(widget.vData.length > 0) {
      widget.vData.map((e) => this.total += double.parse(e[SaleAddItemKey.total].toString())).toList();
    }
    return Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                    Text("Import Items", style: headingStyle),
                    Text(
                      "Complete your details. \n Please check your items ready then click confirm.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                    children: <Widget>[
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      _buildRemarkField(),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                    ]
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Text(
                'Total : '+FormatNumber.usdFormat2Digit(total.toString()) + ' USD',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault, color: dropColor),
              ),
              Divider(
                color: Colors.purple[900].withOpacity(0.5),
              ),
              _body(),
              _buildConfirmButton ()
            ],
          ),
        )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Conform', style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700)),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context, widget.vData);
        },
        child: Icon(
            Icons.arrow_back
        ),
      ),
      backgroundColor: Colors.purple[900],
    );
  }

  Widget _buildConfirmButton () {
    setState(() {
      pay = vPay;
    });
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImportSuccessScreen(
                isAddScreen: true,
                vData: {
                  ImportKey.transactionId: 'BAE20210939',
                  ImportKey.total: this.total
                },
              )),
            );
          },
          child: Container(
            width: size.width,
            height: 45,
            color: Colors.redAccent,
            child: Center(child: Text('Confirm', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
          ),
        ),
      ],
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
        }).toList()
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
              pay = pay - double.parse(item[SaleAddItemKey.total]);
              print('${item[SaleAddItemKey.total]}');
            });
          },
          icon: FaIcon(FontAwesomeIcons.minusCircle,size: 20 , color: Colors.white,),
          label: Text('Remove',style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white))
      ),
    );
  }

  Expanded _body() {
    return Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: <Widget>[
                          _buildDataTable(),
                        ],
                      ),
                    ),
                  ),
                ])
        )
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: remarkController,
      decoration: InputDecoration(
        labelText: "Remark",
        hintText: "Enter remark",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  vPayFunction() {
    widget.vData.map((e)
    {
      double d = double.parse(e[SaleAddItemKey.total]);
      vPay += d;
    }).toList();
    setState(() {
      pay = vPay;
    });
  }

}
