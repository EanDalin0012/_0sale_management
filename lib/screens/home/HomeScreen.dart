import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/home/widgets/product_card.dart';
import 'package:sale_management/screens/testing/easy_localization.dart';
import 'package:sale_management/screens/widgets/country_dropdown/country_page.dart';
import 'package:sale_management/screens/widgets/simple_bar_chart.dart';
import 'package:sale_management/share/database/language_data_base_helper.dart';
import 'package:sale_management/share/database/language_db.dart';
import 'package:sale_management/share/model/data/stock_details_data.dart';
import 'package:sale_management/share/model/stock_details_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sale_management/share/static/language_static.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sale_management/screens/testing/flutter_read_write_file_and_path.dart';
import 'package:sale_management/screens/testing/dropdown_fusuc_testing.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static List<StockDetails> stockDetailData = stockDetailsData;
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  static List<charts.Series<OrdinalSales, String>> _createSampleData1() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
      new OrdinalSales('2018', 200),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  List<dynamic> vData = [];
  @override
  void initState() {
    LanguageDataBase.selectAll().then((value) {
      print('value: ${value}');
      vData = value as List;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.focused))
                          return Colors.red;
                        return null; // Defer to the widget's default.
                      }
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CountryPage()),
                  );
                },
                child: Text('TextButton'),
              )
              ,
            ),
            SliverToBoxAdapter(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.focused))
                          return Colors.red;
                        return null; // Defer to the widget's default.
                      }
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EasyLocalizationScreen()),
                  );
                },
                child: Text('Testing translate'),
              )
              ,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildTitledContainer("Sales1",
                    child: Container(
                        height: 200, child: SimpleBarChart(_createSampleData1(), animate: false))),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: stockDetailData.map((e) =>
                    Container(
                        height: 180,
                        width: size.width,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color(0xffd9dbdb).withOpacity(0.4),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5, left: 10),
                                  child: Text(e.stockName.toString(),style: TextStyle(color: Colors.purple[900],fontSize: 18.0,fontWeight: FontWeight.w700, fontFamily: 'roboto, khmer siemreap'),),
                                ),
                              ),
                              SliverToBoxAdapter(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    // margin: EdgeInsets.only(top: 5),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: e.products.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          // access element from list using index
                                          // you can create and return a widget of your choice
                                          return ProductCard(e.products[index], index);
                                        }
                                    ),
                                  )
                              ),
                              SliverToBoxAdapter(
                                  child: SizedBox(height: 20,)
                              )
                            ]
                        )

                    )
                ).toList(),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 75,
              delegate: SliverChildListDelegate([
                Container(
                    color: Colors.blue,
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () => onPressedSetLocal(),
                      child: Text("Set Flat Button",style: TextStyle(fontSize: 20.0),),
                    ),
                ),FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      onPressedGetLocal().then((value) {
                        showMessage(data: value.toString());
                      });
                    },
                    child: Text("Get Flat Button",style: TextStyle(fontSize: 20.0),),
                  ),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    showMessage(data: 'Testing');
                  },
                  child: Text("Testing Flat Button",style: TextStyle(fontSize: 20.0),),
                ),

                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Toast.show(this.vData.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                  },
                  child: Text("toast",style: TextStyle(fontSize: 20.0),),
                ),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () async {
                    try {
                      Directory documentsDirectory = await getApplicationDocumentsDirectory();
                      Toast.show('documentsDirectory: ${documentsDirectory}', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      Directory appDocDir = await getApplicationDocumentsDirectory();
                      String appDocPath = appDocDir.path;

                      Toast.show('appDocPath: ${appDocPath}', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

                    }catch(e) {
                      Toast.show('catch: ${e}', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                    }



                  },
                  child: Text("Test Get Path",style: TextStyle(fontSize: 20.0),),
                ),

                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    LanguageDataBase.deleteAll().then((value) {
                      Toast.show(value.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                    });
                  },
                  child: Text("delete All LanguageDataBase",style: TextStyle(fontSize: 20.0),),
                ),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    _read();
                  },
                  child: Text("world get",style: TextStyle(fontSize: 20.0),),
                ),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    _save();
                  },
                  child: Text("world save",style: TextStyle(fontSize: 20.0),),
                ),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Toast.show('${MemoryStore.path}', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                  },
                  child: Text("world Path db",style: TextStyle(fontSize: 20.0),),
                ),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FlutterReadWriteFilePath(
                        storage: Storage(),
                      )),
                    );
                  },
                  child: Text("new",style: TextStyle(fontSize: 20.0),),
                ),

                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DropDownMyTesting()),
                    );
                  },
                  child: Text("DropDownMyTesting",style: TextStyle(fontSize: 20.0),),
                ),
              ]),
            ),

          ]
      ),
    );
  }

  Container _buildTitledContainer(String title, {Widget child, double height}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
          ),
          if (child != null) ...[const SizedBox(height: 10.0), child]
        ],
      ),
    );
  }

  onPressedSetLocal() async {
    print('onPressedSetLocal');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('yourKey', 'en');
  }

  Future<String> onPressedGetLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('yourKey');
  }

  showMessage({String data}) {
    print('pricnt');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
              ), //this right here
              child: Text('${data}')
          );
        });
    // _showToast();

  }

  _read() async {
    LanguageDatabaseHelper helper = LanguageDatabaseHelper.instance;
    int rowId = 1;
    Word word = await helper.queryWord(rowId);
    if (word == null) {
      print('read row $rowId: empty');
    } else {
      print('read row $rowId: ${word.word} ${word.frequency}');
    }
    Toast.show(word.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

  _save() async {
    Word word = Word();
    word.word = 'hello';
    word.frequency = 15;
    LanguageDatabaseHelper helper = LanguageDatabaseHelper.instance;
    int id = await helper.insert(word);
    print('inserted row: $id');
    Toast.show('${id}', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }


}
