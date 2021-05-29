import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-Vindo'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      
      backgroundColor: Colors.red,
      
      body: Row(
        children: [

          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, left: 70),  
            child: Container(
              //padding: EdgeInsets.only(top: 40, left: 50),
              alignment: Alignment.center, 
             // width: 210,
             // height: 100,
              child: Text('Registado', style: TextStyle(color: Colors.white, fontSize: 50),),
            ),
          ),
          
        ],
      ),


      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
        },
        label: Text('logout', style: TextStyle(color: Colors.red),),
        icon: Icon(Icons.logout, color: Colors.red,),
        backgroundColor: Colors.white,
      )

    );
  }
}