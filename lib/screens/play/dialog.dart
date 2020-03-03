import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/utils/provider.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog(
      {@required this.corr,
      @required this.result,
      @required this.callback});

  double corr;
  List result;
  VoidCallback callback;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  Provider _provider = Provider();

  @override
  Widget build(BuildContext context) {

    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.corr / 100))),
        title: Column(
          children: <Widget>[
            Center(
                child: Text('Winner', style: TextStyle(fontFamily: "Elite"))),
            Divider()
          ],
        ),
        content: Text(
                'Your score is ${widget.result[1]} from ${widget.result[0]}.'
                '\n\n'
                'Time: ${_provider.time}',
            style: TextStyle(fontFamily: "Elite")
        ),


        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              color: Colors.blueAccent,
              onPressed: widget.callback),
        ],
      ),
    );
  }
}
