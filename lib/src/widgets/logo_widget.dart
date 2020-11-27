import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: 170,
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/tag-logo.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Toche',
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}