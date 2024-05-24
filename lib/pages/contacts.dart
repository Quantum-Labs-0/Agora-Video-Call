import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currant/core/currant_core.dart';
import 'package:currant/pages/call/video_call.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool validateEmail = false;
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
              'Contacts',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Profiles')
                .doc(uid)
                .snapshots(),
            builder: (context, snapshotProfile) {
              if (snapshotProfile.hasData) {
                final data = snapshotProfile.data!;
                List myContacts = data['Contacts'];
                final channelName = '$uid-${const Uuid().v1()}';
                return ListView.builder(
                    itemCount: myContacts.length,
                    itemBuilder: (context, index) {
                      final contact = myContacts[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => VideoCall(
                                      channelName: channelName,
                                      role: ClientRoleType
                                          .clientRoleBroadcaster))),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      child: Text(
                                        contact["Name"],
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      child: Row(
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
                                              child: Text(
                                                contact["Email"],
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              )),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              child: Center(
                                                  child:
                                                      // add text overflow to all text
                                                      contact['Date'] ==
                                                              DateTimeFormat.format(
                                                                      DateTime
                                                                          .now(),
                                                                      format:
                                                                          'j M Y')
                                                                  .toString()
                                                          ? Text(
                                                              contact['Time'],
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            )
                                                          : Text(
                                                              contact['Date'],
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
                            TextField(
                              controller: email,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 5),
                                  errorText: validateEmail
                                      ? 'Use Gmail or Icloud email'
                                      : null,
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(width: 1)),
                                  label: Text('Email')),
                            ),
                            TextField(
                              controller: phone,
                              cursorHeight: 20,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 5),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(width: 1)),
                                  label: Text('Phone Number')),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      !CurrantCore().isEmail(email.text)
                                          ? validateEmail = false
                                          : validateEmail = true;
                                      name.text.isEmpty
                                          ? validateName = true
                                          : validateName = false;
                                    });

                                    if (validateEmail && !validateName) {
                                      setState(() {
                                        adding = true;
                                      });
                                      CurrantCore().addContact(
                                          email, name, phone, context);
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
