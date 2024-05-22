import 'package:currant/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({super.key, required this.channelName, required this.role});
  final String channelName;
  final ClientRoleType role;

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final users = <int>[];
  int? remoteUid;
  int? localUid;
  final infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine rtcEngine;

  Future<void> initialize() async {
    if (appID.isEmpty) {
      setState(() {
        infoStrings.add('App ID missing');
        infoStrings.add('Agora engine not starting');
      });
      return;
    }
    //initialize Agora engine
    rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(const RtcEngineContext(
        appId: appID,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting));
    await rtcEngine.setClientRole(role: widget.role);
    await rtcEngine.enableVideo();
    //add event handlers
    agoraEventHandler();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 1920, height: 1080));
    await rtcEngine.setVideoEncoderConfiguration(configuration);
    await rtcEngine.joinChannel(
        token: tokenID,
        channelId: widget.channelName,
        uid: 0,
        options: const ChannelMediaOptions());
  }

  Future<void> agoraEventHandler() async {
    rtcEngine.registerEventHandler(RtcEngineEventHandler(
      onError: (err, msg) {
        setState(() {
          final info = 'Error: $msg';
          infoStrings.add(info);
        });
      },
      onJoinChannelSuccess: (connection, elapsed) {
        setState(() {
          final info =
              'Joined Channel: ${connection.channelId} UID: ${connection.localUid}';
          infoStrings.add(info);
        });
      },
      onLeaveChannel: (connection, stats) {
        setState(() {
          const info = 'Left Channel';
          infoStrings.add(info);
          users.clear();
        });
      },
      onUserJoined: (connection, remoteUid, elapsed) {
        setState(() {
          final info = 'User Joined: ${connection.localUid}';
          infoStrings.add(info);
          users.add(connection.localUid!);
        });
      },
      onUserOffline: (connection, remoteUid, reason) {
        setState(() {
          final info = 'User Offline: ${connection.localUid}';
          infoStrings.add(info);
          users.remove(connection.localUid);
        });
      },
      onFirstRemoteVideoFrame: (connection, remoteUid, width, height, elapsed) {
        setState(() {
          final info =
              'First Video Frame: ${connection.localUid} $width x $height';
          infoStrings.add(info);
        });
      },
    ));
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() async {
    users.clear();
    await rtcEngine.leaveChannel();
    await rtcEngine.release();
    super.dispose();
  }

  Widget _remoteVideo() {
    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: rtcEngine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: localUid != null
                    ? GestureDetector(
                        onDoubleTap: () {
                          Navigator.of(context).pop();
                        },
                        child: AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: rtcEngine,
                            canvas: const VideoCanvas(uid: 0),
                          ),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
