import 'package:currant/core/currant_core.dart';
import 'package:currant/pages/authentication/sign_up.dart';
import 'package:currant/tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool validateEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: email,
                cursorHeight: 20,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5),
                    errorText:
                        validateEmail ? 'Use Gmail or Icloud email' : null,
                    border:
                        UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                    label: Text('Email')),
              ),
              TextField(
                controller: password,
                cursorHeight: 20,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5),
                    border:
                        UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                    label: Text('Password')),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        CurrantCore().isEmail(email.text)
                            ? validateEmail = true
                            : validateEmail = false;
                      });
                      if (validateEmail) {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text)
                            .then((value) => Navigator.of(context)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Tree()),
                                    (route) => false));
                      }
                    },
                    child: Text('Login')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignUp())),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
