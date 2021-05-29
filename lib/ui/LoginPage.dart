import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_firebase/ui/homeRegister.dart';
import 'package:flutter_firebase/ui/homeLogin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String email, password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //fulando@mail.com - 123456789
  //siclano@mail.com - 987654321

  // Registrar
  Future _register() async{  

    setState(() {
      email = _emailController.text;
      password = _passwordController.text;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterPage()));

    } on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        print('senha fraca');
      } else if(e.code == 'email-already-in-use'){
        print('Email já cadastrato');
      }
    } catch(e){
      print(e);
    }
  }

  // Login
  Future _login() async{

    setState(() {
      email = _emailController.text;
      password = _passwordController.text;
    });

    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
      );

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginHome()));

    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        print('email não cadastrado');
      } else if (e.code == 'wrong-password'){
        print('Senha errada');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: [

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "e-mail",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            ),

            SizedBox(
              height: 10,
            ),

            TextFormField(
              keyboardType: TextInputType.text,
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'senha',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(
              height: 10,
            ),

            Container(  // botão de login
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),

              child: SizedBox.expand(
                child: TextButton(
                  onPressed: _login,
                  child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 20),)
                )
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Container(  // botão para registrar
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),

              child: SizedBox.expand(
                child: TextButton(
                  onPressed: _register,
                  child: Text('Registrar', style: TextStyle(color: Colors.white, fontSize: 20),)
                )
              ),
            )

          ],
        ),
      ),
    );
  }
}