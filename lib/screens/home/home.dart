import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foobar/services/auth.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.yellow, Colors.red],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Welcome'),
          elevation: 1.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.exit_to_app),
              label: const Text(''),
              style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.email ?? "na",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    user.uid,
                    style: const TextStyle(color: Colors.white54),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('tests')
                        .snapshots(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot snapshot,
                    ) {
                      if (!snapshot.hasData) {
                        return const Text("Loading");
                      }
                      final List<DocumentSnapshot> documents =
                          snapshot.data.docs;
                      List list = documents.map((doc) {
                        return doc.data();
                      }).toList();
                      return Text(list.toString());
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
