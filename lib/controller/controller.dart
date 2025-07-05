import 'dart:developer';

import 'package:firebase_curd/models/model.dart';
import 'package:firebase_curd/services/service.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier{
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  DataServices dataServices = DataServices();
  List<DataModel> fireStoreData = [];

  void addData()async{
    try{
      dataServices.addDataToFireBase(
        DataModel(title: titleController.text, subtitle: subtitleController.text)
      );
    }catch (e){
      log('error');
    }
    subtitleController.clear();
    titleController.clear();
    getData();
    notifyListeners();
  }
  void getData()async{
    fireStoreData = await dataServices.getDataFromFireBase();
    if(fireStoreData.isNotEmpty){
      log('data get success');
    }
    notifyListeners();
  }

  void deleteData(String id)async{
    dataServices.deleteDataFromFirebase(id);
    getData();
    notifyListeners();
  }

  void updateData(String id,DataModel firebaseData)async{
    dataServices.updateDataInFirebase(id, firebaseData);
    getData();
    notifyListeners();

  }

}