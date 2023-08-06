
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color color;
  final bool loading;
  Button({super.key,required this.text,required this.color,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return Container(height: 30,
      width: 270,
      child: Center(child:  loading==true?CircularProgressIndicator():Text(text)),
      decoration: BoxDecoration(
          color: color
      ),

    );
  }
}
