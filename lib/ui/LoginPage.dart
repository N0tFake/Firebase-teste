import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_firebase/ui/registerPage.dart';
import 'package:flutter_firebase/ui/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String email, password;
  bool passwordWrog;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  //fulando@mail.com - 123456789
  //siclano@mail.com - 987654321

  // Login
  Future _login() async{

    if(!_formKey.currentState.validate()){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('processing data')));
    }

    setState(() {
      email = _emailController.text;
      password = _passwordController.text;
    });

    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
      );

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));

    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        print('email não cadastrado');
      } else if (e.code == 'wrong-password'){
        print('senha errada');
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _emailForm(),
                  
                  SizedBox(
                    height: 10,
                  ),

                  _passwordForm(),
               
                  SizedBox(
                    height: 10,
                  ),

                  _buttonLogin()
                ],
              ) 
            ),

            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 10,
            ),

            Container(  // botão para registrar
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),

              child: SizedBox.expand(
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterPage()));
                  },
                  child: Text('Registrar', style: TextStyle(color: Colors.white, fontSize: 20),)
                )
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _emailForm(){
    return TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: _validarEmail,
              decoration: InputDecoration(
                labelText: "e-mail",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            );
  }

  String _validarEmail(String value){
    String pattern = r'@';
    RegExp regExp = RegExp(pattern);
    if(value.length == 0){
      return 'Informe o email';
    }else if(!regExp.hasMatch(value)){
      return 'Email inválido';
    }
  }

  Widget _passwordForm(){
    return TextFormField(  // senha
              keyboardType: TextInputType.text,
              controller: _passwordController,
              obscureText: true,
              validator: _validarPassword,
              decoration: InputDecoration(
                labelText: 'senha',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
              style: TextStyle(fontSize: 20),
            );
  }

  String _validarPassword(String value){
    if(value == null || value.isEmpty){
      return 'Informe a senha';
    }
  }

  Widget _buttonLogin(){
    return Container(  // botão de login
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),

              child: SizedBox.expand(
                child: TextButton(
                  onPressed: _login,
                  child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 20),)
                )
              ),
            );
  }

}