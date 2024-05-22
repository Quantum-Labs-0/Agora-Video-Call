import 'package:currant/pages/authentication/sign_in.dart';
import 'package:currant/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Tree extends StatefulWidget {
  const Tree({super.key});

  @override
  State<Tree> createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  @override
  Widget build(BuildContext context) {
    double widthLength = MediaQuery.of(context).size.width;
    return widthLength > 500
        ? Scaffold(
            body: Container(
              child: Center(
                child: const Text('Designed for mobile phone screen size'),
              ),
            ),
          )
        : Scaffold(
            body: Container(
              child: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Home();
                    }
                    return SignIn();
                  }),
            ),
          );
  }
}
