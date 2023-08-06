

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bubble extends StatelessWidget {
  final String text;
  const bubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,style: TextStyle(fontSize: 20),),
        ),


        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),

          color: Colors.lightBlueAccent,

        ),
      ),
    );
  }
}
