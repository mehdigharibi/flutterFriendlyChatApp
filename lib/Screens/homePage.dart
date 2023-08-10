// ignore_for_file: no_leading_underscores_for_local_identifiers, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffriendlychat/Screens/chatPage.dart';
import 'package:ffriendlychat/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void Singout() async {
    final authervice = Provider.of<AuthService>(context, listen: false);
    authervice.Signout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FriendlyChat'),
        actions: [IconButton(onPressed: Singout, icon: Icon(Icons.logout))],
      ),
      body: _buildUsersList(),
    );
  }

  Widget _buildUsersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        //check of Error in Snapshot
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _builditems(doc))
                .toList());
      },
    );
  }

  Widget _builditems(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => chatPage(
                      reciverEmail: data['email'], reciverUid: data['uid'])));
        },
      );
    } else {
      return Container();
    }
  }
}
