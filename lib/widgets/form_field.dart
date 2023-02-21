import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelTextForm;
  final String type;


  const FormFieldWidget({super.key, required this.controller, required this.labelTextForm, required this.type});

  String? validateNotEmpty(String ?value) {
    if (value==null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    else if(type == "password" || type == "email")
    {
      if(type=="password") {
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
      }
      else{
        if(!value.contains("@") && !value.contains("."))
        {
          return 'Not valid email';
        }
      }
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator:validateNotEmpty,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: labelTextForm,

      ),
    );
  }
}