import 'package:flutter/material.dart';
import 'package:messenger/Provider/AuthProvider.dart';
import 'package:provider/provider.dart';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final pro=Provider.of<Auth>(context,listen: false);
      pro.Sign(context, _emailController.text, _passwordController.text);

      // Simulate login process with a delay (replace this with your actual login logic)
     }
  }

  @override
  Widget build(BuildContext context) {
     final pro=Provider.of<Auth>(context,listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
             
              children: <Widget>[
                SizedBox(height: 180,),
                  Icon(
                  Icons.message,
                  size: 100,
                ),
                SizedBox(height: 30,),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                 decoration: InputDecoration(fillColor: Colors.grey,filled: true,hintText: 'email',prefixIcon: Icon(Icons.email),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white10)),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
          
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                 decoration: InputDecoration(fillColor: Colors.grey,filled: true,hintText: 'password',prefixIcon: Icon(Icons.lock),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white10)),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
          
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 40,
                  width: 240,
                  color: Color.fromARGB(31, 20, 18, 18),
                  
                  child: Center(
                    child: TextButton(
                      onPressed: pro.loading ? null : _login,
                      child: pro.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text('Login'),
                    ),
                  ),
                ),
                  SizedBox(height: 9),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("if you have not account ?"),
                  GestureDetector(
                    child: Text(" Login"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )
              ],
            ),
          ),
        ),
      ),
    );    
  }
}

