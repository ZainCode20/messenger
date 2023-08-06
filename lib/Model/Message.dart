

import 'package:cloud_firestore/cloud_firestore.dart';

class Message{




  final String senderid;
  final String senderemail;
  final String receiverid;
  final String message;
  final Timestamp timestamp;
  Message({required this.senderid,required this.senderemail, required this.receiverid,required this.message,required this.timestamp});

  Map<String,dynamic> toMap(){
    return{
      'senderemail':senderemail,
      'senderid':senderid,
      'receiverid':receiverid,
      'message':message,
      'timestamp':timestamp

    };
  }
}
