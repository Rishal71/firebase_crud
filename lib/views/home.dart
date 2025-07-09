import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_curd/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirestoreSevices firestoreSevices = FirestoreSevices();
  final TextEditingController textController = TextEditingController();

  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textController),
        actions: [
          ElevatedButton(
            onPressed: () {
              if(docID == null){
                firestoreSevices.addNote(textController.text);
              }else{
                firestoreSevices.updatedNote(docID, textController.text);
              }
              textController.clear();
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text('Note'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreSevices.getNotesStream(),
         builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasData){
               List notesList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context,index){
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;
                  Map<String,dynamic> data = 
                  document.data() as Map<String,dynamic>;
                  String noteText = data['note'];
                  return ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          openNoteBox(docID: docID);
                        }, icon: Icon(Icons.settings)),
                        IconButton(onPressed: (){
                          firestoreSevices.deleteNote(docID);
                        }, icon: Icon(Icons.delete)),
                      ],
                    ),);
                });
            }else{
              return Text('no notes...');
            }
         }),

    );
  }
}
