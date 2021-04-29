import 'package:flutter/material.dart';
import 'package:sale_management/screens/widgets/customer_dropdown/customer_items.dart';
import 'package:sale_management/share/model/key/m_key.dart';

class CustomerDropDown extends StatefulWidget {
  final ValueChanged<Map<dynamic, dynamic>> onChanged;
  final Map<dynamic, dynamic> vCustomer;
  final Color color;

  CustomerDropDown({
    @required this.vCustomer,
    this.color,
    this.onChanged
  });

  @override
  _CustomerDropDownState createState() => _CustomerDropDownState();
}

class _CustomerDropDownState extends State<CustomerDropDown> {

  Map customer;

  @override
  Widget build(BuildContext context) {
    this.customer = widget.vCustomer;

    return  Container(
      child: buildSingleProduct(),
    );
  }

  @override
  void initState() {

  }

  Widget buildSingleProduct() {
    final onTap = () async {
      final feedBackCustomerData = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomerItems(
          vCustomer: this.customer,
        )),
      );
      if (feedBackCustomerData == null) return;
      setState(() {
        this.customer = feedBackCustomerData;
        widget.onChanged(this.customer);
      });

    };

    return buildCountryPicker(
      title: 'Select Country',
      child: customer == null ? buildListTile(
          title: 'Select Customer',
          leading: Icon(
            Icons.info_outline,
            color: Colors.black54,
          ),
          onTap: onTap
      ) : buildListTile(
        title: customer[CustomerKey.customerName],
        leading: buildLeading(customer[CustomerKey.url]),
        onTap: onTap,
      ),
    );
  }

  Widget buildListTile({
    @required String title,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    return ListTile(
      onTap: onTap,
      // leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: widget.color, fontSize: 18),
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
          // Text(
          //   title,
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // const SizedBox(height: 12),
          Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              child: child),
        ],
      );

  Widget buildLeading(String url) {
    return Container(
      width: 40,
      height: 40,
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
