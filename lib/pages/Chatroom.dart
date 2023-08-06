



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Components/chatBubble.dart';
import 'package:messenger/Provider/chatProvider.dart';
import 'package:messenger/Services/SesssionController.dart';
import 'package:provider/provider.dart';

class chatroom extends StatefulWidget {
   final String receiveremial;
   final String receiverid;
   chatroom({ super.key , required this.receiveremial, required this.receiverid,});


  @override
  State<chatroom> createState() => _chatroomState();
}
final messageController=TextEditingController();
class _chatroomState extends State<chatroom> {
  final auth =FirebaseAuth.instance;


  @override

  Widget build(BuildContext context) {
    final pro=Provider.of<chatprovider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiveremial.toString()),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: _GetMessage()),
            _inputField(context: context)
          ],

        ),
      ),
    );
  }
  //geting messge list
  Widget _GetMessage( ){
    final pro=Provider.of<chatprovider>(context);
    return StreamBuilder(

        stream:pro.getMessage(widget.receiverid, auth.currentUser!.uid),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text("Eror");

          }
          if(snapshot.connectionState==ConnectionState.waiting){

            return Text("Loading");
          }
          return ListView(
              children:snapshot.data!.docs
                  .map((document)=>_messageItems(document)).toList()

          );

        });
  }
//message items
  Widget _messageItems(DocumentSnapshot document){
    Map<String,dynamic>data=document.data() as Map<String,dynamic>;
    var alignment=(data['senderid']==auth.currentUser!.uid)?Alignment.centerRight:Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(children: [
        Text(data['senderemail'].toString()),
        // Text(data['message'].toString()),
        bubble(text: data['message'].toString())
        
      ],),
    );
  }
  //input field
  Widget _inputField({required BuildContext context}){
    final pro=Provider.of<chatprovider>(context);
    return Material(
      color: Colors.grey,
      child: Container(decoration: BoxDecoration(border:Border.all()),
        child: Row(children: [
          Expanded(child:TextField(
            controller: messageController,
            textInputAction: TextInputAction.send  ,
            

          )),
          IconButton(onPressed: (){
          pro.sendMessage(widget.receiverid, messageController.text,auth.currentUser!.uid);
           messageController.clear();



          }, icon: Icon(Icons.send))
        ],),
      ),
    );
  }
}
