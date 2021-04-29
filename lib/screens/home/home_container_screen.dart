import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sale_management/screens/home/widgets/stock_details.dart';
import 'package:sale_management/screens/home/widgets/stock_details1.dart';
import 'package:sale_management/screens/widgets/simple_bar_chart.dart';
import 'package:sale_management/share/model/data/stock_details_data.dart';
import 'package:sale_management/share/model/stock_details_model.dart';

class HomeContainerScreen extends StatefulWidget {
  @override
  _HomeContainerScreenState createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  List<charts.Series> seriesList;
  Color  _primaryColor = Colors.deepPurpleAccent;
  Color _secondaryColor = Colors.deepOrangeAccent;
  static List<StockDetails> stockDetailData = stockDetailsData;

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

  static List<charts.Series<Sales, String>> _createRandomData() {
    final random = Random();

    final desktopSalesData = [
      Sales('2015', random.nextInt(100)),
      Sales('2016', random.nextInt(100)),
      Sales('2017', random.nextInt(100)),
      Sales('2018', random.nextInt(100)),
      Sales('2019', random.nextInt(100)),
    ];

    final tabletSalesData = [
      Sales('2015', random.nextInt(100)),
      Sales('2016', random.nextInt(100)),
      Sales('2017', random.nextInt(100)),
      Sales('2018', random.nextInt(100)),
      Sales('2019', random.nextInt(100)),
    ];

    final mobileSalesData = [
      Sales('2015', random.nextInt(100)),
      Sales('2016', random.nextInt(100)),
      Sales('2017', random.nextInt(100)),
      Sales('2018', 30),
      Sales('2019', random.nextInt(100)),
    ];

    return [
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: desktopSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      ),
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: tabletSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },
      ),
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: mobileSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.teal.shadeDefault;
        },
      )
    ];
  }


  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: <Widget>[
        _buildStats(),
        // _buildStats1(),
        SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: stockDetailData.map((activity) =>
                  Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xfff1f1f1),
                  border: Border.all(color: Colors.grey[300], width: 4)
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(activity.stockName,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                        StockDetailsScreen(activity.products)
                      ]
                  )
                  )).toList()
            )
        ),
        SliverToBoxAdapter(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: stockDetailData.map((activity) =>
                    StockDetailsScreen1(activity.products)).toList()
            )
        ),
        // SliverToBoxAdapter(
        //     child: StockDetailsScreen(stockDetailData[0].products)
        // ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("Sales1",
                child: Container(
                    height: 200, child: SimpleBarChart(_createSampleData1(), animate: false))),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("Sales",
                child: Container(
                    height: 200, child: _barChart(size))),
          ),
        ),
        // _buildActivities(context),
      ],
    );
    // return SingleChildScrollView(
    //     child: Row(
    //       children: <Widget>[
    //         _barChart(size)
    //       ],
    //     )
    // );
  }
  Container _barChart(Size size) {
    return Container(
      width: size.width,
      height: 300,
      padding: EdgeInsets.all(20.0),
      child: barChart(),
    );
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: false,
      vertical: true,
    );
  }

  SliverPadding _buildActivities(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child: _buildTitledContainer(
          "Activities",
          height: 280,
          child: Expanded(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: activities
                  .map((activity) =>
                  Column(
                    children: <Widget>[
                      CircleAvatar(radius: 20, backgroundColor: Theme
                          .of(context)
                          .buttonColor,
                        child: activity.icon != null ? Icon(
                            activity.icon, size: 18.0) : null,
                      ),
                      const SizedBox(height: 8.0),
                      Text(activity.title, textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ],
                  ),
              ).toList(),
            ),
          ),
        ),
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

  SliverPadding _buildStats1() {
    final TextStyle stats = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white);
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hello",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
            ),

          ],
        ),
      ),
    );
  }

  SliverPadding _buildStats() {
    final TextStyle stats = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white);
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid.count(
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.5,
        crossAxisCount: 3,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "+500",
                  style: stats,
                ),
                const SizedBox(height: 5.0),
                Text("Leads".toUpperCase())
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "+500",
                  style: stats,
                ),
                const SizedBox(height: 5.0),
                Text("Leads".toUpperCase())
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.pink,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "+300",
                  style: stats,
                ),
                const SizedBox(height: 5.0),
                Text("Customers".toUpperCase())
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "+1200",
                  style: stats,
                ),
                const SizedBox(height: 5.0),
                Text("Orders".toUpperCase())
              ],
            ),
          ),
        ],
      ),
    );
  }


  Expanded _mainBody() {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _container(
                isSaving: true,
                title: 'Saving Account',
                deposit: '\$5,000',
                rate: '+3,50%',
                progress: 25
            ),
            SizedBox(height: 16,),
            // _container(
            //     isSaving: false,
            //     title: 'Financial Customer',
            //     deposit: '\$12,000',
            //     rate: '+3,50%',
            //     progress: 25
            // ),
          ],
        ),
      ),
    );
  }



  Container production(ProductStockDetails productStockDetails) {
    final TextStyle stats = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "+500",
            style: stats,
          ),
          const SizedBox(height: 5.0),
          Text(productStockDetails.productName.toString())
        ],
      ),
    );
  }

  Container _container({
    bool isSaving,
    String title,
    String deposit,
    String rate,
    int progress
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSaving ? Colors.white : _secondaryColor,
        border: isSaving ? Border.all(color: _primaryColor.withOpacity(0.1), width: 2) : null,
        boxShadow: isSaving ? [] : [BoxShadow(color: _secondaryColor.withOpacity(0.4),offset: Offset(0,8), blurRadius: 10)],
      ),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  value: progress / 100,
                  strokeWidth: 5,
                  backgroundColor: isSaving ? _primaryColor.withOpacity(0.2) : _primaryColor.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(isSaving ? _secondaryColor: Colors.white),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                child: Text(progress.toString() + '%', style: TextStyle(color: isSaving ? _primaryColor : Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              )
            ],
          ),
          SizedBox(width: 30,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(color: isSaving ? _primaryColor : Colors.white,fontSize: 18,fontWeight: FontWeight.w500)),
              SizedBox(height: 12,),
              Row(
                children: <Widget>[
                  _reportInnerCell(
                      isSaving: isSaving,
                      title: 'Deposit',
                      value: deposit
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  _reportInnerCell(
                      isSaving: isSaving,
                      title: 'Rate',
                      value: rate
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Column _reportInnerCell({
    bool isSaving,
    String title,
    String value
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(color: isSaving ? _primaryColor.withOpacity(0.5): Colors.white,fontSize:  14,fontWeight: FontWeight.w500),),
        SizedBox(height: 4,),
        Text(value, style: TextStyle(color: isSaving ? Colors.black87: Colors.white,fontSize:  14,fontWeight: FontWeight.w500),),
      ],
    );
  }

}

final List<Activity> activities = [
  Activity(title: "Results", icon: FontAwesomeIcons.listOl),
  Activity(title: "Messages", icon: FontAwesomeIcons.sms),
  Activity(title: "Appointments", icon: FontAwesomeIcons.calendarDay),
  Activity(title: "Video Consultation", icon: FontAwesomeIcons.video),
  Activity(title: "Summary", icon: FontAwesomeIcons.fileAlt),
  Activity(title: "Billing", icon: FontAwesomeIcons.dollarSign),
];
class Activity {
  final String title;
  final IconData icon;
  Activity({this.title, this.icon});
}

class Sales {
  final String year;
  final int sales;

  Sales(this.year, this.sales);
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
