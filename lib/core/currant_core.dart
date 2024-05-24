import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currant/pages/authentication/verify_email.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CurrantCore {
  signup(
      TextEditingController email,
      TextEditingController password,
      TextEditingController name,
      TextEditingController phone,
      BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((value) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance.collection('Profiles').doc(uid).set({
        'Name': name.text,
        'Phone': phone.text,
        'Email': email.text,
        'Contacts': []
      });
    }).then((value) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => VerifyEmail()));
    });
  }

  addContact(TextEditingController email, TextEditingController name,
      TextEditingController phone, BuildContext context) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('Profiles').doc(uid).update({
      'Contacts': FieldValue.arrayUnion([
        {
          'Name': name.text,
          'Phone': phone.text,
          'Email': email.text,
          'Date':
              DateTimeFormat.format(DateTime.now(), format: 'j M Y').toString(),
          'Time': DateTimeFormat.format(DateTime.now(), format: 'H : i a')
              .toString()
        }
      ])
    });
    Navigator.of(context).pop();
  }

  bool isEmail(String text) {
    if (text.endsWith("@icloud.com")) {
      return text.endsWith("@icloud.com");
    }
    return text.endsWith("@gmail.com");
  }

  bool isCorrectFormat(String text) {
    // Regular expression pattern to check for spaces before "@gmail.com"
    final gmailPattern = RegExp(r"^\S+@gmail\.com$");
    final icloudPattern = RegExp(r"^\S+@icloud\.com$");
    if (icloudPattern.hasMatch(text)) {
      return icloudPattern.hasMatch(text);
    }
    return gmailPattern.hasMatch(text);
  }

  Future sendMessage(
      String chatID, TextEditingController messageController) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference thisChat =
        FirebaseFirestore.instance.collection('Chats').doc(chatID);
    thisChat.update({
      'Messages': FieldValue.arrayUnion([
        {
          'Content': {'Text': messageController.text, 'Media': []},
          'Date':
              DateTimeFormat.format(DateTime.now(), format: 'j M Y').toString(),
          'Time': DateTimeFormat.format(DateTime.now(), format: 'H : i a')
              .toString(),
          'TimeStamp':
              DateTimeFormat.format(DateTime.now(), format: 'YMy').toString(),
          'UID': uid,
          'Edited': false
        }
      ]),
    });
  }

  Future enterChatRoom(
    String otherUID,
    Function updateState,
    String roomID,
  ) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot room_0 = await FirebaseFirestore.instance
        .collection('Chats')
        .doc('M-${uid + otherUID}')
        .get();
    DocumentSnapshot room_1 = await FirebaseFirestore.instance
        .collection('Chats')
        .doc('M-${otherUID + uid}')
        .get();
    if (!room_0.exists && !room_1.exists) {
      String chatID = 'M-${uid + otherUID}';
      FirebaseFirestore.instance.collection('Chats').doc(chatID).set({
        'Chat ID': chatID,
        'Members': [uid, otherUID],
        'Messages': []
      });
      roomID = chatID;
      updateState;
    } else if (room_0.exists && !room_1.exists) {
      String chatID = 'M-${uid + otherUID}';
      roomID = chatID;
      updateState;
    } else if (!room_0.exists && room_1.exists) {
      String chatID = 'M-${otherUID + uid}';
      roomID = chatID;
      updateState;
    }
  }

  Future createGroup(
    TextEditingController groupNameController,
  ) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    String chatID = 'G-${const Uuid().v1()}';
    FirebaseFirestore.instance.collection('Chats').doc(chatID).set({
      'Chat ID': chatID,
      'Name': groupNameController.text,
      'Members': [uid],
      'Messages': []
    });
  }
}
