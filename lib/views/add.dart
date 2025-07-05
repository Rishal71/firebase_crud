import 'dart:developer';

import 'package:firebase_curd/controller/controller.dart';
import 'package:firebase_curd/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class addPage extends StatelessWidget {
 
  addPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<FirebaseProvider>(
          builder:(context, textfeild, child) =>  Column(
            spacing: 20,
            children: [
              TextFormField(
                controller: textfeild.titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "feild is empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "title", border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: textfeild.subtitleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "feild is empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'subtitle', border: OutlineInputBorder()),
              ),
              Consumer<FirebaseProvider>(
                builder:(context, firestore, child) {
                  return ElevatedButton(
                    onPressed: () {
                     firestore.addData();
                     showSnackBar(message: "data added", context: context);
                     Navigator.pop(context);
                    },
                    child: Text("submit"));
                } 
              ),
            ],
          ),
        ),
      ),
    );
  }
}