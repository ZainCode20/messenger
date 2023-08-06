import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Provider/AuthProvider.dart';
import 'package:messenger/Provider/chatProvider.dart';
import 'package:messenger/pages/home.dart';
import 'package:messenger/pages/login.dart';
import 'package:messenger/pages/signup.dart';
import 'package:messenger/pages/splashScreen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(

      MultiProvider(providers: [

        ChangeNotifierProvider(create: (_)=>Auth()),
        ChangeNotifierProvider(create: (_)=>chatprovider())
      ],
        child: MyApp()),
      );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      debugShowCheckedModeBanner: false,
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/log': (context) => login(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/sign': (context) => Signup(),
          '/home': (context) => home(),

        },

      home: login()
    );
  }
}

