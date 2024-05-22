import 'package:currant/core/currant_core.dart';
import 'package:currant/pages/authentication/sign_in.dart';
import 'package:currant/pages/authentication/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool validateError = false;
  bool creating = false;
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
              TextField(
                controller: confirmPassword,
                cursorHeight: 20,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 1,
                    )),
                    errorText: validateError ? 'Passwords do not match' : null,
                    label: Text('Confirm Password')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        !CurrantCore().isEmail(email.text)
                            ? validateEmail = false
                            : validateEmail = true;
                        password.text != confirmPassword.text
                            ? validateError = true
                            : validateError = false;
                      });
                      print('$validateEmail && $validateError');

                      if (validateEmail && !validateError) {
                        setState(() {
                          creating = true;
                        });
                        CurrantCore().signup(email, password, context);
                        setState(() {
                          creating = false;
                        });
                      }
                    },
                    child: creating ? Text('Creating') : Text('Create')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignIn())),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Login',
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
