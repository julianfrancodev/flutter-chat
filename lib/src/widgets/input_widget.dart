import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool obscuredText;

  InputWidget(
      {@required this.icon,
      @required this.placeholder,
      @required this.textEditingController,
      @required this.textInputType,
      @required this.obscuredText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, right: 20),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      ),
      child: TextField(
        cursorColor: Colors.amber,
        controller: textEditingController,
        autocorrect: false,
        keyboardType: this.textInputType,
        obscureText: this.obscuredText,
        decoration: InputDecoration(
          fillColor: Colors.amber,
            focusColor: Colors.amber,
            hoverColor: Colors.amber,
            prefixIcon: Icon(this.icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: this.placeholder),
      ),
    );
  }
}
