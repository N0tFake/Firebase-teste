import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/ui/LoginPage.dart';
import 'package:flutter_firebase/ui/home.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  String name, age, email, password;

  // add user firestore
  void _addData(name, age, email){
    var firebaseUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).set({
      'nome': name,
      'idade': age,
      'email': email
    }).then((value) => print('adicionado'));
  }

  // Registrar
  Future _register() async{  

    setState(() {
      email = _emailController.text;
      password = _passwordController.text;
      name = _nameController.text;
      age = _ageController.text;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      _addData(name, age, email);

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redistrar'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              }, 
              icon: Icon(Icons.arrow_back)
            );
          },
        ),
      ),
      
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'nome',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            ),

            SizedBox(height: 10,),

            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'idade',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 20,
                ), 
              ],
            ),

            SizedBox(height: 10,),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'email',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            ),

            SizedBox(height: 10,),

            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'senha',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            ),

            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'confirme a senha',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                ),
              ),
            ),

            SizedBox(height: 40,),

            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),

              child: SizedBox.expand(
                child: TextButton(
                  onPressed: _register,
                  child: Text('Cadastrar', style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              )
            )

          ],
        ),
      )

    );
  }
}