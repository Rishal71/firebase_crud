
import 'package:firebase_curd/controller/controller.dart';
import 'package:firebase_curd/views/add.dart';
import 'package:firebase_curd/views/edit.dart';
import 'package:firebase_curd/views/single.dart';
import 'package:firebase_curd/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<FirebaseProvider>(context,listen: false).getData();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => addPage()));
            }),
        appBar: AppBar(
          title: Text("Firebase"),
        ),
        body: Consumer<FirebaseProvider>(
          builder:(context, value, child) =>  ListView.builder(
            itemCount: value.fireStoreData.length,
            itemBuilder: (context, index) {
           final data = value.fireStoreData[index];
              final docId = data.id;
              return ListTile(
                title: Text(data.title!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdatePAge(
                                      id: docId,
                                      title: data.title,
                                      subtitle: data.subtitle)));
                        },
                        icon: Icon(Icons.edit)),
                    Consumer<FirebaseProvider>(
                      builder: (context, value, child) => IconButton(
                          onPressed: () {
                            value.deleteData(docId!);
                            showSnackBar(
                                message: "data deleted", context: context);
                          },
                          icon: Icon(Icons.delete)),
                    ),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleDocumentFuture(userId: docId.toString())));
                    }, child: child)
                  ],
                ),
              );
            },
          ),
        ));

  }
}