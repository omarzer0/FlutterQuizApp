import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function(String) callback;

  CustomButton(this.text, this.callback);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: TextButton(
          onPressed: () {
            callback(text);
          },
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.teal, width: 2)),
            ),
          ),
        ),
      ),
    );
  }
}
