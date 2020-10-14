import 'package:flutter/material.dart';

class FireBaseText extends StatelessWidget {
  final String hint;
  final bool showText;
  final Function onChanged;
  FireBaseText({this.hint = "", this.showText = false, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        obscureText: showText,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(
              width: 0.8,
            ),
          ),
          hintText: hint,
          labelText: hint,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
