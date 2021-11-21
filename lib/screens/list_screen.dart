import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:free_dongdong/screens/dongtube_detail_screen.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late String init_id;
  late String mid_id;
  late String fin_id;
  late String name;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Center(
            child: Container(
              width: 40,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/youtube_channel_logo.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          '동동이 유투브 리스트',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontFamily: 'DonghyunKo'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          MessageStream(
            firestore: _firestore,
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  final firestore;

  MessageStream({required this.firestore});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('Dongtube_List').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageWidgets = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs;
        for (var message in messages) {
          final init = message.get('init');
          final mid = message.get('mid');
          final fin = message.get('fin');
          final name = message.get('name');

          final messageWidget = MessageBubble(
            initId: init,
            midId: mid,
            finId: fin,
            project_name: name,
          );

          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: false,
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String initId;
  final String midId;
  final String finId;
  final String project_name;

  const MessageBubble({Key? key, required this.initId, required this.midId, required this.finId, required this.project_name}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            child: ListTile(
              tileColor: Colors.orangeAccent,
              title: Text(project_name, style: TextStyle(fontSize: 30,color: Colors.white, fontFamily: 'DonghyunKo'),),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => DongtubeDetailScreen(initId: initId,midId: midId,finId: finId, name: project_name,)));
            }),
        Divider(),
      ],
    );
  }
}
