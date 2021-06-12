import 'dart:async';

import 'package:evoting/model/login.dart';
import 'package:evoting/page/mainPage.dart';
import 'package:evoting/page/mainResultPage.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginUser login;
  late LoginUser isvoting;

  final _formKey = GlobalKey<FormState>();

  final voter = TextEditingController();
  final password = TextEditingController();
  String id = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginHeader(),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: <Widget>[
                          LoginFormText(
                            pass: false,
                            textHint: 'Voter Id',
                            textController: voter,
                          ),
                          Padding(padding: EdgeInsets.all(3)),
                          LoginFormText(
                            pass: true,
                            textHint: 'Password',
                            textController: password,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.amberAccent),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    LoginUser.login(voter.text, password.text)
                                        .then((value) {
                                      setState(() {
                                        login = value;
                                      });
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Mohon Tunggu..')));
                                    Timer(Duration(seconds: 2), () {
                                      if (login.error == null) {
                                        LoginUser.isVoting(login.id as String)
                                            .then((value) {
                                          setState(() {
                                            isvoting = value;
                                          });
                                          if (isvoting.error == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Silahkan Melakukan Voting')));
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainPage(
                                                          id: login.id
                                                              as String,
                                                        )));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(isvoting.error
                                                        as String)));
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainResultPage()));
                                          }
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    login.error as String)));
                                      }
                                    });
                                  } else {
                                    return null;
                                  }
                                },
                                child: Text('Login')),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginFormText extends StatelessWidget {
  final textController;
  final textHint;
  final pass;
  const LoginFormText(
      {Key? key,
      required this.textHint,
      required this.textController,
      required this.pass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: pass ? true : false,
      controller: textController,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        hintText: this.textHint,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kolom $textHint Harus Diisi!!';
        } else {
          return null;
        }
      },
    );
  }
}

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(
            "Login",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            "Silahkan Login Untuk Melanjutkan",
            style: Theme.of(context)
                .textTheme
                .overline!
                .copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
