import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(CodespaceApp());
}

class CodespaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodespaceMPT',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CodespaceMPT'),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('repos').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final repos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: repos.length,
            itemBuilder: (context, index) {
              final repo = repos[index];
              return ListTile(
                title: Text(repo['name']),
                subtitle: Text(repo['description']),
              );
            },
          );
        },
      ),
    );
  }
}
