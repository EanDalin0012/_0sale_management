import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/import_add_key.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/model/key/member_key.dart';
import 'package:sale_management/share/model/key/package_product_key.dart';
import 'package:sale_management/share/model/key/product_key.dart';
import 'package:sale_management/share/utils/number_format.dart';
import 'package:sale_management/screens/sale/sale_success_screen.dart';
import 'package:sale_management/screens/widgets/member_dropdown/member_dropdown.dart';

class SaleAddConfirm extends StatefulWidget {
  final List<dynamic> vData;
  final ValueChanged<List<dynamic>> onChanged;
  SaleAddConfirm({
    Key key,
    @required this.vData,
    this.onChanged
  }):super(key: key);

  @override
  _SaleAddConfirmState createState() => _SaleAddConfirmState();
}

class _SaleAddConfirmState extends State<SaleAddConfirm> {

  var colorValue = Colors.deepPurple;
  Size size;
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);

  var remarkController = new TextEditingController();
  var nameValueController = new TextEditingController();
  var phoneController = new TextEditingController();
  var memberController = new TextEditingController();


  var i = 0;
  double pay = 0.0;
  double vPay = 0.0;
  Map vCustomer;
  var total = 0.0;
  var selectedMember = false;
  final _formCustomerKey = GlobalKey<FormState>();
  final _formMemberKey = GlobalKey<FormState>();
  var isClickConfirm  = false;
  Map member;


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
      body: SafeArea(
        child: _buildBody(),
      ),
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

  Widget _buildBody () {
    setState(() {
      pay = vPay;
    });
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: SizeConfig.screenHeight * 0.02), // 4%
                      Text("Sale Items", style: headingStyle),
                      Text(
                        "Complete your details. \n Please check sale items then click confirm.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    inputChipCustomer(),
                    SizedBox(width: 15,),
                    inputChipMember()
                  ],
                ),
                this.selectedMember ? _buildIsMemberSelected() :  _buildIsCustomerSelected(),

                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  'Total : '+FormatNumber.usdFormat2Digit(total.toString()) + ' USD',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault, color: dropColor),
                ),
                Divider(
                  color: Colors.purple[900].withOpacity(0.5),
                ),
                _body(),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              !this.selectedMember ? validationCustomer() : validationMember();
            },
            child: Container(
              width: size.width,
              height: 45,
              color: Colors.redAccent,
              child: Center(child: Text('Confirm', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
            ),
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
          var product = e[SaleAddItemKey.product];
          var packageProduct = e[SaleAddItemKey.packageProduct];
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
                DataCell(Text(e[SaleAddItemKey.quantity].toString())),
                DataCell(Text(e[SaleAddItemKey.total].toString() + ' \$')),
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
              widget.onChanged(widget.vData);
              pay = pay - double.parse(item[SaleAddItemKey.total]);
            });
          },
          icon: FaIcon(FontAwesomeIcons.minusCircle,size: 20 , color: Colors.white,),
          label: Text('Remove',style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white))
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
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
        );
  }

  TextFormField _buildCustomerField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid customer name.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Customer",
        hintText: "Enter customer name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      controller: phoneController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid phone.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "Enter phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildMemberField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: memberController,
      onTap: () async {
        final memberBackData = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MemberDropDownPage(vMember: this.member)),
        );
        if(memberBackData == null) {
          return;
        }
        setState(() {
          this.member = memberBackData;
          memberController.text = this.member[MemberKey.name];
          checkFormValid();
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid member.";
        }
        return null;
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Member",
        hintText: "Select member",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.text,
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

  Widget inputChipMember() {
    return InputChip(
      padding: EdgeInsets.all(2.0),
      elevation: 5,
      avatar: CircleAvatar(
        backgroundColor: this.selectedMember ? Colors.blue.shade600 : Colors.redAccent,
        child: Text('M'),
      ),
      label: Text('Member', style: TextStyle(color: selectedMember ? Colors.white: Colors.black, fontFamily: fontFamilyDefault)),
      selected: selectedMember,
      selectedColor: Color(0xff32b8a1),
      deleteIcon: selectedMember ? Icon(Icons.check_circle_outline_outlined, color: Colors.deepPurple,) : Icon(Icons.highlight_remove_outlined, color: Colors.indigo),
      onSelected: (bool selected) {
        setState(() {
          selectedMember = selected;
        });
      },
      onDeleted: () {},
    );
  }

  Widget inputChipCustomer() {
    return InputChip(
      padding: EdgeInsets.all(2.0),
      elevation: 5,
      avatar: CircleAvatar(
        backgroundColor: !this.selectedMember ? Colors.blue.shade600 : Colors.redAccent,
        child: Text('C'),
      ),
      label: Text('Customer', style: TextStyle(color: !this.selectedMember ? Colors.white: Colors.black, fontFamily: fontFamilyDefault),),
      selected: !this.selectedMember,
      selectedColor: Color(0xff32b8a1),
      deleteIcon: !selectedMember ? Icon(Icons.check_circle_outline_outlined, color: Colors.indigo,) : Icon(Icons.highlight_remove_outlined, color: Colors.indigo,),
      onSelected: (bool selected) {
        setState(() {
          selectedMember = !selected;
        });
      },
      onDeleted: () {},
    );
  }

  Widget _buildIsCustomerSelected() {
    return Form(
      key: _formCustomerKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
            children: <Widget>[
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            _buildCustomerField(),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            _buildPhoneField(),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            _buildRemarkField(),
          ]
        ),
      ),
    );
  }

  Widget _buildIsMemberSelected() {
    return Form(
      key: _formMemberKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildMemberField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildRemarkField(),
            ]
        ),
      ),
    );
  }

  validationCustomer() {
    print('validationCustomer');
    if(this._formCustomerKey.currentState.validate()) {
      rout();
    }
  }

  validationMember() {
    if(this._formMemberKey.currentState.validate()) {
      rout();
    }
  }
  void rout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SaleSuccessScreen(
        isAddScreen: true,
        vData: {
          ImportTransactionKey.transactionID: 'AXD20210320',
          ImportAddKey.total: this.total
        },
      )),
    );
  }
  void checkFormValid() {
    if(isClickConfirm && this.selectedMember != true) {
      _formCustomerKey.currentState.validate();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SaleSuccessScreen(
          isAddScreen: true,
          vData: {
            ImportTransactionKey.transactionID: 'AXD20210320',
            ImportAddKey.total: this.total
          },
        )),
      );
    }
  }
}
