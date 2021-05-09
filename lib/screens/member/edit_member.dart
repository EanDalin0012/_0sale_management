import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/member/widget/edit_member_form.dart';

class EditMemberScreen extends StatefulWidget {
  final Map vMember;
  EditMemberScreen({Key key,@required this.vMember}):super(key: key);

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<EditMemberScreen> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          foregroundColor: Colors.purple[900],
          title: Text("Member"),
        ),
        body: SafeArea(
          child: EditMemberForm(vMember: widget.vMember),
        )
    );
  }
}
