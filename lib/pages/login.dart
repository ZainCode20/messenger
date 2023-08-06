import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger/pages/signup.dart';
import 'package:provider/provider.dart';

import '../Components/Button.dart';
import '../Components/TextField.dart';
import '../Provider/AuthProvider.dart';

class login extends StatefulWidget {
  // final void Function() onTap;
  const login({
    super.key,
  });

  @override
  State<login> createState() => _loginState();
}



class _loginState extends State<login> {
  TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
   void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
 

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context,listen: false);
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Icon(
                Icons.message,
                size: 100,
              ),
              Form(
                key:_formKey ,
                  child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  TextField(),
                  textfield(
                    text: emailController,
                    hint: "Emial",
                    obsecure: false,
                    icon: Icons.email,
                    mesg: 'enter emial',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textfield(
                    text: passwordController,
                    hint: "Password",
                    obsecure: true,
                    icon: Icons.password,
                    mesg: 'enter password',
                  ),
                ],
              )),
              SizedBox(height: 40),
              GestureDetector(
                child:auth.loading?Center(child: CircularProgressIndicator()): Button(
                  text: "Login",
                  color: Color.fromARGB(31, 20, 18, 18),
                  loading: auth.loading,
                ),
                onTap: () {
                   if(_formKey.currentState!.validate()){
                  auth.log(
                      context, emailController.text, passwordController.text);
                       
                  }
                 
                },
              ),
              SizedBox(height: 9),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("if you have not account ?"),
                  GestureDetector(
                    child: Text(" Sign up"),
                    onTap: () {
                      Navigator.pushNamed(context, '/sign');
                    },
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
