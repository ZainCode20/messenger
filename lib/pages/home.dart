
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Provider/AuthProvider.dart';
import 'Chatroom.dart';


class home extends StatefulWidget {
   home({super.key,});

  @override
  State<home> createState() => _homeState();

}

class _homeState extends State<home> {
  final auth=FirebaseAuth.instance;
  @override

  Widget build(BuildContext context) {
    final pro =Provider.of<Auth>(context ,listen: false);
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Chat"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){pro.Signout(context);}, icon:Icon(Icons.logout))
        ],),
        body: _UserList()
      ),
    );
  }
  Widget _UserList( ){
    return StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text("Eror");

          }
          if(snapshot.connectionState==ConnectionState.waiting){

            return Text("Loading");
          }
          return ListView(
            children:snapshot.data!.docs
                .map<Widget>((doc)=>_buildUserItem(context,doc)).toList()

          );

        });
  }
  Widget _buildUserItem(BuildContext context, DocumentSnapshot document){
    Map<String,dynamic>data=document.data()! as Map<String,dynamic>;
    if(auth.currentUser!.email!=data['email']){
      return ListTile(
        title: Text(data['email']),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>chatroom(receiveremial: data['email'].toString(), receiverid: data['uid'].toString())));

        },
      );
    }
    else{
      return Container();
    }


  }
}
