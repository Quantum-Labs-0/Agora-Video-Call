import 'package:flutter/material.dart';

class CallLogs extends StatefulWidget {
  const CallLogs({super.key});

  @override
  State<CallLogs> createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple[400],
        title: Row(
          children: [
            Text(
              'Call Logs',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Container(),
    );
  }
}
