import 'package:flutter/material.dart';
import 'package:sale_management/screens/widgets/circular_progress_indicator/widget/loader_one.dart';

class CircularProgressLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       LoaderOne(
    //           color: Colors.red
    //       ),
    //       SizedBox(height: 10.0,),
    //       // LoaderTwo(),
    //       SizedBox(height: 10.0,),
    //     ],
    //   ),
    // );
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
