import 'package:flutter/material.dart';

class GenderSelectOption extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final FormFieldValidator<String> validator;
  GenderSelectOption({Key key, this.value, this.onChanged, this.validator}) : super(key: key);

  @override
  _GenderSelectOptionState createState() => _GenderSelectOptionState();
}

class _GenderSelectOptionState extends State<GenderSelectOption> {

  var _radioValue = null;
  int f = 0;
  int m = 0;

  var selectedBorderColor = Colors.blueAccent;

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print('value: ${widget.value.toString()}');
    print('${widget.validator(widget.value.toString())}');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Gender'),
        ),

        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('1');
                setState(() {
                  this._radioValue = 0;
                  this.f = 0;
                  this.m = 1;
                });
              },
              child: Container(
                width: (size.width / 2 ) - 40,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: this.m == 1 ? selectedBorderColor : Colors.black),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child:  Text('Male'),
                    ),
                    Radio(
                      value: 0,
                      activeColor: Colors.indigo,
                      groupValue: _radioValue,
                      onChanged: (v) {
                        setState(() {
                          _radioValue = v;
                          this.f = 0;
                          this.m = 1;
                        } );
                      },
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('2');
                setState(() {
                  this._radioValue = 1;
                  this.f = 1;
                  this.m = 0;
                });
              },
              child: Container(
                width: (size.width / 2 ) - 40,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: this.f == 1 ? selectedBorderColor : Colors.black),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child:  Text('Female'),
                    ),
                    Radio(
                      value: 1,
                      activeColor: Colors.indigo,
                      groupValue: _radioValue,
                      onChanged: (v) {
                        setState(() {
                          _radioValue = v;
                          this.f = 1;
                          this.m = 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        if (widget.validator(widget.value.toString()) == null)
          Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text('${widget.validator(widget.value.toString())}'),
        ),

      ],
    );
  }
}
