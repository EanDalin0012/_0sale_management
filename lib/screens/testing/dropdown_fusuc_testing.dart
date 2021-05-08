import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';

class DropDownMyTesting extends StatefulWidget {
  const DropDownMyTesting({Key key}) : super(key: key);

  @override
  _DropDownMyTestingState createState() => _DropDownMyTestingState();
}

class _DropDownMyTestingState extends State<DropDownMyTesting> {
  FocusNode _node;
  bool _focused = false;
  FocusAttachment _nodeAttachment;
  Color _color = Colors.white;

  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'Button');
    _node.addListener(_handleFocusChange);
    _nodeAttachment = _node.attach(context, onKey: _handleKeyPress);
  }

  void _handleFocusChange() {
    if (_node.hasFocus != _focused) {
      setState(() {
        _focused = _node.hasFocus;
      });
    }
  }

  KeyEventResult _handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      print('Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.keyR) {
        print('Changing color to red.');
        setState(() {
          _color = Colors.red;
        });
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.keyG) {
        print('Changing color to green.');
        setState(() {
          _color = Colors.green;
        });
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.keyB) {
        print('Changing color to blue.');
        setState(() {
          _color = Colors.blue;
        });
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }


  @override
  void dispose() {
    _node.removeListener(_handleFocusChange);
    // The attachment will automatically be detached in dispose().
    _node.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _nodeAttachment.reparent();
    return Form(

      child: Column(
        children: <Widget>[GestureDetector(
          onTap: () {
            print('onTap');
            if (_focused) {
              _node.unfocus();
            } else {
              _node.requestFocus();
            }
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: _focused ? _color : Colors.white,
              alignment: Alignment.center,

            ),
        ),
    ]
      ),
    );
  }
}
