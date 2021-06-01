import 'package:flutter/material.dart';

class ValidatorRegister {

  String nameValidator(String value){
    if(value.length == 0){
      return 'Informe o nome';
    }
  }

  String ageValidator(String value){
    if(value.length == 0){
      return 'Informe sua idade';
    }
  }

  String emailValidator(String value){
    String pattern = r'@';
    RegExp regExp = RegExp(pattern);
    if(value.length == 0){
      return 'Informe o email';
    }else if(!regExp.hasMatch(value)){
      return 'Email inválido';
    }
  }

  String passwordValidator(String value){
    if(value == null || value.isEmpty){
      return 'Informe a senha';
    }else if(value.length <= 8){
      return 'A senha deve conter ao menos 8 caracteres';
    }
  }
}