import 'package:flutter/material.dart';




class MyInputWidget extends StatelessWidget {
  const MyInputWidget({ Key? key, required this.label, required this.controller, required this.valid}) : super(key: key);

  final String label;
  final dynamic controller;
  final bool valid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
      child: TextField(
          // initialValue: 'e.g Apple',
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 1.0),
            ),
            labelText: label,
            labelStyle: const TextStyle(color: Colors.green),
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.green,
            ),
            errorText: valid? null:'Input can\'t be empty and must be grater than 2 characters',
          ),
          controller: controller,
        ),
      );
  }
}

