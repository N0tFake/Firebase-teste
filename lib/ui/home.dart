import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firebaseUser = FirebaseAuth.instance.currentUser;

  String name;

  // deslogar
  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
    print('Deslogado');
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Map<String, dynamic> data;
  Future<DocumentSnapshot> _getData() async{
    CollectionReference userReference = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot snapshot = await userReference.doc(_firebaseUser.uid).get();
    return snapshot;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }
  
  @override
  Widget build(BuildContext context) {

    CollectionReference userReference = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.hasData && !snapshot.data.exists){
              return Text('Sem nome');
            }else if(snapshot.connectionState == ConnectionState.done){
              Map<String, dynamic> data = snapshot.data.data();
              print('$data');
              return Text('${data['nome']} - ${data['idade']} anos');
            }else{
              print(_firebaseUser.uid);
              return Text('Loading...');            
            }
          },
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      
      backgroundColor: Colors.blue,
      
      body: Row(
        children: [
          
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, left: 110),  
            child: Container(
              alignment: Alignment.center, 
              child: Text('CAsa kkkkkkk', style: TextStyle(color: Colors.white, fontSize: 50),),
            ),
          ),
          
        ],
      ),


      floatingActionButton: FloatingActionButton.extended(
        onPressed: _signOut,
        label: Text('logout', style: TextStyle(color: Colors.red),),
        icon: Icon(Icons.logout, color: Colors.red,),
        backgroundColor: Colors.white,
      )

    );
    
  }

  Container buildContainer(){
    return Container(
      child: FutureBuilder(
        future: _getData(),
        initialData: 'carregando',
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Center(
              child: Text(
                snapshot.data
              )
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
  

}