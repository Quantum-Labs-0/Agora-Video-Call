import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:currant/pages/video_call.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final channelName = TextEditingController();
  bool validateError = false;
  ClientRoleType? role = ClientRoleType.clientRoleBroadcaster;

  Future onJoin() async {
    setState(() {
      channelName.text.isEmpty ? validateError = true : validateError = false;
    });
    if (channelName.text.isNotEmpty) {
      //Add permissions here
      //
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VideoCall(channelName: channelName.text, role: role!)));
    }
  }

  @override
  void dispose() {
    channelName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.green[400],
              child: Center(child: Text('Image')),
            ),
            TextField(
              controller: channelName,
              decoration: InputDecoration(
                  label: Text('Channel Name'),
                  border:
                      UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                  errorText:
                      validateError ? 'Channel name is mandatory' : null),
            ),
            RadioListTile(
              value: ClientRoleType.clientRoleBroadcaster,
              groupValue: role,
              onChanged: (ClientRoleType? value) {
                setState(() {
                  role = value;
                });
              },
              title: Text('Broadcaster'),
            ),
            RadioListTile(
              value: ClientRoleType.clientRoleBroadcaster,
              groupValue: role,
              onChanged: (ClientRoleType? value) {
                setState(() {
                  role = value;
                });
              },
              title: Text('Audience'),
            ),
            ElevatedButton(onPressed: onJoin, child: Text('Join'))
          ],
        ),
      ),
    );
  }
}
