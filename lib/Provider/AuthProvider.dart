
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Services/SesssionController.dart';
import 'package:messenger/Services/toast.dart';

class Auth with ChangeNotifier{

  final auth =FirebaseAuth.instance;
  final fire=FirebaseFirestore.instance;
  bool _loading=false;
  bool get loading=>_loading;


  Future Sign(BuildContext context,String email, String password )async{
    _loading=true;


    await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      show.toast("Account Created");


      Navigator.pushNamed(context, '/log');
       fire.collection("user").doc(auth.currentUser!.uid).set({
      "uid":auth.currentUser!.uid,
      "email":email



    },SetOptions(merge: true));

      _loading =false;
    }).onError((error, stackTrace) {
      show.toast(error.toString());
    });

    



  }


  void log(BuildContext context,String email, String password )async{


     auth.signInWithEmailAndPassword(email: email, password: password).then((value) {

      _loading=true;
   Navigator.pushNamed(context, '/home');
   show.toast("Logged");
   _loading=false;

    }).onError((error, stackTrace) {
      show.toast(error.toString());
    });
    
   



  }
  void Signout(BuildContext context){

    auth.signOut().then((value) {
      show.toast("Signed out");
      Navigator.pushNamed(context, '/log');
    } ).onError((error, stackTrace) {
      show.toast("Somethig wrong");
    });
  }

}