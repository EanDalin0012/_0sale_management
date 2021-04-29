import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:sale_management/screens/home/home_container_screen.dart';
import 'package:sale_management/screens/notification/notification_screen.dart';
import 'package:sale_management/screens/sale/sale_screen.dart';
import 'package:sale_management/screens/sign_in/sign_in_screen.dart';
import 'package:sale_management/screens/widgets/contry_dropdown/country_page.dart';
import 'package:sale_management/screens/widgets/contry_dropdown/provider/country_provider.dart';
import 'package:sale_management/screens/widgets/simple_bar_chart.dart';
import 'package:sale_management/share/constant/constantcolor.dart';
import 'package:sale_management/share/model/country.dart';
import 'package:sale_management/screens/widgets/contry_dropdown/flag_widget.dart';

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
  CountryModel country;
  List<CountryModel> countries = [];
  var isMultiSelection = false;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).primaryColor,
    body: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundColor: Color(0xffE6E6E6),
              radius: 30,
              child: Icon(
                Icons.person,
                color: Color(0xffCCCCCC),
              ),
            )
          ),
          buildSingleCountry(),
          const SizedBox(height: 24),
          buildMultipleCountry(),
        ],
      ),
    ),
  );

  Widget buildSingleCountry() {
    final onTap = () async {
      final country = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CountryPage(countries: countries,isMultiSelection: false,)),
      );

      if (country == null) return;

      setState(() => this.country = country);
      countries.add(this.country);
      isMultiSelection = true;
    };

    return buildCountryPicker(
      title: 'Select Country',
      child: country == null? buildListTile(title: 'No Country', onTap: onTap)
          : buildListTile(
        title: country.name,
        leading: FlagWidget(code: country.code),
        onTap: onTap,
      ),
    );
  }

  Widget buildMultipleCountry() {
    final countriesText = countries.map((country) => country.name).join(', ');
    final onTap = () async {
      final countries = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CountryPage(
              isMultiSelection: true,
              countries: List.of(this.countries),
            )),
      );

      if (countries == null) return;

      setState(() => this.countries = countries);
    };

    return buildCountryPicker(
      title: 'Select Countries',
      child: countries.isEmpty
          ? buildListTile(title: 'No Countries', onTap: onTap)
          : buildListTile(title: countriesText, onTap: onTap),
    );
  }

  Widget buildListTile({
    @required String title,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }

  Widget buildCountryPicker({
    @required String title,
    @required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );

  AppBar _appBar() {
    return AppBar(
      title: Text('App'),
      centerTitle: true,
      backgroundColor: Colors.purple[900],
      elevation: 0,
      leading: new Container(),
      actions: <Widget>[
        Stack(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
              child: Container(
                height: 80,
                padding: EdgeInsets.only(
                    top: 5,
                    right: 10,
                    left: 10
                ),
                child: Icon(Icons.notifications),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: EdgeInsets.only(
                  left: 6,
                  top: 1
              ),
              margin: EdgeInsets.only(
                  top: 7,
                  left: 20
              ),
              child: Text('2', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );
          },
          child: Container(
            height: 40,
            padding: EdgeInsets.only(
                top: 7,
                right: 5,
                left: 5
            ),
            margin: EdgeInsets.only(
                right: 5
            ),
            child: Icon(Icons.logout),
          ),
        ),
      ],
    );
  }
}
