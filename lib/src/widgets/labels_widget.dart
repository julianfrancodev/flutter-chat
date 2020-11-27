import 'package:flutter/material.dart';

class LabelsWidget extends StatelessWidget {
  final String question;
  final String redirection;
  final String path;

  LabelsWidget(
      {@required this.question,
      @required this.redirection,
      @required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.question,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w200),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, this.path);
            },
            child: Text(
              this.redirection,
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
