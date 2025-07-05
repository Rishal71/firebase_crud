import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_curd/models/model.dart';

class DataServices{
  final CollectionReference fireStroData = FirebaseFirestore.instance.collection('data');

  Future<List<DataModel>> getDataFromFireBase()async{
    try{
      final QuerySnapshot snapshot = await fireStroData.get();
      return snapshot.docs.map((doc)=>DataModel.fromFirebase(doc.data() as Map<String,dynamic>,doc.id)).toList();
    }catch (e){
      log('Error Fetching Data: $e');
      throw Exception('Error Fetching data');
    }
  }

  Future<void>addDataToFireBase(DataModel firebaseData) async{
    try{
      log('adding Data: ${firebaseData.title}');
      await fireStroData.add(firebaseData.toFirestore());
    }catch(e){
      log('Error Adding Data: $e');
    }
  }

  Future<void>deleteDataFromFirebase(String id)async{
    try{
      await fireStroData.doc(id).delete();
      log('Delete Data with ID: $id');
    }catch (e){
      log('Error Deleting Data: $e');
    }
  }

  Future<void>updateDataInFirebase(String id,DataModel firebaseData)async{
    try{
      await fireStroData.doc(id).update(firebaseData.toFirestore());
      log('Update Data with ID: $id');
    }catch (e){
      log('Error Updating Data: $e');
    }
  }
}