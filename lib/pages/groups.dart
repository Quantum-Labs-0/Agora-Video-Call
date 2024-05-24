import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currant/core/currant_core.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  TextEditingController name = TextEditingController();
  bool validateName = false;
  bool adding = false;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple[400],
        title: Row(
          children: [
            Text(
              'Groups',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Chats')
                .where('Members', arrayContains: uid)
                .snapshots(),
            builder: (context, snapshotChats) {
              if (snapshotChats.hasData) {
                List myGroups = snapshotChats.data!.docs;
                return ListView.builder(
                    itemCount: myGroups.length,
                    itemBuilder: (context, index) {
                      final group = myGroups[index];
                      List groupMembers = group["Members"];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    child: Text(
                                      group["Name"],
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    child: Text(
                                      groupMembers.length.toString(),
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
              return Container();
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: name,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 5),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(width: 1)),
                                  label: Text('Name')),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      name.text.isEmpty
                                          ? validateName = true
                                          : validateName = false;
                                    });

                                    if (!validateName) {
                                      setState(() {
                                        adding = true;
                                      });
                                      CurrantCore().createGroup(name);
                                      setState(() {
                                        adding = false;
                                      });
                                    }
                                  },
                                  child: adding ? Text('Adding') : Text('Add')),
                            ),
                          ]),
                    ),
                  ))),
    );
  }
}
