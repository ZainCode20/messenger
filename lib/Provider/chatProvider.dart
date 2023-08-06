

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:messenger/Model/Message.dart';
import 'package:messenger/Services/toast.dart';

class chatprovider with ChangeNotifier{


  final auth=FirebaseAuth.instance;
  final fire=FirebaseFirestore.instance;

  Future<void>sendMessage(String receiverid,String message,String senderid)async{
    final currentUseremail=auth.currentUser!.email.toString();
    final currentUserId=auth.currentUser!.uid;
Timestamp timestamp=Timestamp.now();


   Message newMessage = Message(
         senderid: senderid,
        senderemail:currentUseremail,
        receiverid: receiverid,
        message: message,
        timestamp: timestamp);
    List<String>ids=[currentUserId,receiverid];
    ids.sort();
    String chatromIds=ids.join("_");
    show.toast("Message sent");
    
    await fire.collection("chatroom").doc(chatromIds).collection('message').add(newMessage.toMap());
  }

  Stream<QuerySnapshot>getMessage(String userid, String otherid){


    List<String>ids=[userid,otherid];
    ids.sort();
    String chatromIds=ids.join("_");
   return   fire.collection("chatroom").doc(chatromIds).collection('message').orderBy('timestamp',descending: false).snapshots();


  }


}