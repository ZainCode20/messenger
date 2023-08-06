
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  final TextEditingController text;
  final String hint,mesg;
  final IconData icon;
   
  final bool obsecure;
  textfield({super.key,required this.text,required this.hint,required this.obsecure,required this.icon, required this.mesg,  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: text,
      obscureText: obsecure,
      decoration: InputDecoration(fillColor: Colors.grey,filled: true,hintText: hint,prefixIcon: Icon(icon), 
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white10)),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),


   validator: (value) {
    if (value == null || value.isEmpty) {
      return mesg;
    }
    return null;
  },
  
    );
  }
}
