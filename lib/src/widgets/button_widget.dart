import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final Function onPress;
  final String buttonName;


  ButtonWidget({@required this.onPress, @required this.buttonName});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: RaisedButton(
        onPressed: this.onPress,
        elevation: 2,
        highlightElevation: 5,
        color: Colors.amber,
        shape: StadiumBorder(),
        child: Container(
            width: double.infinity,
            height: 55,
            child: Center(
              child: Text(
                this.buttonName,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            )),
      ),
    );
  }
}
