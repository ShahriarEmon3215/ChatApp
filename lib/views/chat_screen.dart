import 'package:chat_app/constants.dart';
import 'package:chat_app/views/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String screen = 'chat-screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  var user;
  var textController = TextEditingController();

  String messege;

  @override
  void initState() {
    super.initState();

    getcurrentUser();
  }

  getcurrentUser() async {
    try {
      final _user = await _auth.currentUser;
      if (_user != null) {
        this.user = _user;
        print(this.user.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacementNamed(context, WelcomeScreen.screen);
              }),
        ],
        title: Text('Whatsapp'),
        backgroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
              stream: _fireStore
                  .collection('messeges')
                  .orderBy('datetime', descending: false)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>>
                      snapshot) {
                if (snapshot.hasData) {
                  final messeges = snapshot.data.docs.reversed;

                  List<MessageBubble> messageList = [];
                  for (var message in messeges) {
                    var text = message['text'];
                    var sender = message['sender'];

                    var messageBubble =
                        MessageBubble(user: user, sender: sender, text: text);
                    messageList.add(messageBubble);
                  }
                  messageList.reversed;
                  return Expanded(
                      child: ListView(
                    reverse: true,
                    children: messageList,
                  ));
                } else {
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text("Loading chats...."),
                  ));
                }
              },
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      
                      controller: textController,
                      onChanged: (value) {
                        messege = value;
                      },
                      decoration: customTextFieldDecoration.copyWith(hintText: "Type message..."),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await _fireStore.collection('messeges').add({
                          'text': messege,
                          'sender': user.email,
                          'datetime': DateTime.now(),
                        });
                      } catch (e) {
                        print(e);
                      }

                      textController.clear();
                    },
                    child: Icon(Icons.send, size: 38, color: Colors.black,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key key,
    @required this.user,
    @required this.sender,
    @required this.text,
  }) : super(key: key);

  final user;
  final sender;
  final text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: user.email == sender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
         // Text(sender),
          Material(
            color: user.email == sender ? Colors.black87 : Colors.black12,
            borderRadius: user.email == sender
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(
                      15,
                    ),
                    bottomRight: Radius.circular(15))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(
                      15,
                    ),
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15)),
            child: Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  text,
                  style: TextStyle(
                    color: user.email == sender ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
