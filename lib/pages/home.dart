import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currant/pages/contacts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                'Currant',
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
                  List chats = snapshotChats.data!.docs;
                  return ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        List members = chat['Members'];
                        String otherUID = '';
                        for (var element in members) {
                          if (element != uid) {
                            otherUID = element;
                            break;
                          }
                        }

                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: StreamBuilder(
                                      stream: null,
                                      builder: (context, snapshot) {
                                        return CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.black,
                                        );
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          child: Text('Contact Name'),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.5,
                                                  child: Text('Message')),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  child: Center(
                                                      child: Text(
                                                    '20 : 34 pm',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ))),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
                return Container();
              }),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.home_menu,
          childPadding: EdgeInsets.only(bottom: 10),
          children: [
            SpeedDialChild(child: Icon(Icons.groups)), // go to groups page
            SpeedDialChild(
              child: Icon(Icons.contacts),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Contacts())),
            ), // go to contacts page
            SpeedDialChild(
                child:
                    Icon(Icons.contact_phone)) // go to video & audio call page
          ],
        ));
  }
}
