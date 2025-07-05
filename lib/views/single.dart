import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SingleDocumentFuture extends StatelessWidget {
  final String userId;

  const SingleDocumentFuture({super.key, required this.userId});

  // 🔍 Function to fetch data one time
  Future<Map<String, dynamic>?> fetchDocument() async {
    try {
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('data') // ✅ Correct collection name
          .doc(userId)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        return null; // Document not found
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Single Document")),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchDocument(), // 🔥 Call the fetch function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Document not found'));
          }

          final data = snapshot.data!;
          final title = data['title'] ?? 'No title';
          final subtitle = data['subtitle'] ?? 'No subtitle';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: $title', style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 16),
                Text('Subtitle: $subtitle', style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
