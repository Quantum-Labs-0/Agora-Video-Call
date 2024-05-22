import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool validateError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: email,
                cursorHeight: 20,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5),
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
                        password.text != confirmPassword.text
                            ? validateError = true
                            : validateError = false;
                      });
                    },
                    child: Text('Validate')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
