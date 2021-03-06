import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/home/Home.dart';
import 'package:sale_management/screens/import/add_import.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/search_widget/search_widget.dart';
import 'package:sale_management/screens/widgets/two_tab/two_tab.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/import/all_transaction_import.dart';
import 'package:sale_management/screens/import/product_import.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({Key key}) : super(key: key);

  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {

  var isNative = false;
  Size size;
  var selectedProduct = true;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: WillPopScope(
        onWillPop:  () async {
          return Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Center(
                child: Column(
                  children: <Widget>[// 4%
                    Text("Import Product", style: headingStyle),
                    this.selectedProduct ? Center(
                      child: Text(
                        "All Product Import.",
                        textAlign: TextAlign.center,
                      ),
                    ) :
                    Center(
                      child: Text(
                        "All Transaction Import.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              TwoTabs(
                textTab0: 'Product',
                textTab1: "Transaction",
                onChanged: (tabIndex) {
                  setState(() {
                    if(tabIndex == 0) {
                      this.selectedProduct = true;
                    }else if (tabIndex == 1) {
                      this.selectedProduct = false;
                    }
                  });
                },
              ),
              Expanded(
                child: this.selectedProduct ? ProductImportBody() : AllTransactionImportBody(),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Import'),
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
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'Search name',
                onChange: (value) {
                },
              ),
            ),
          ],
        ),
      ): null,
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddImportScreen()),
        );
      },
      tooltip: 'Increment',
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }
}
