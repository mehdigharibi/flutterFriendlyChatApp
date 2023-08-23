import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffriendlychat/Widgets/custom_Textfield.dart';
import 'package:ffriendlychat/services/chat/chatservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatPage extends StatefulWidget {
  final String reciverEmail;
  final String reciverUid;
  const chatPage(
      {super.key, required this.reciverEmail, required this.reciverUid});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final chatSerive _chatService = chatSerive();

  final ScrollController _scrollcontroller = ScrollController();

  Future<void> _refresh() async {
    await Future.delayed(Duration(milliseconds: 400));
    _scrollDown();
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  //Function for detect Emoji in text [and EnCrease Font Size]
  bool isEmoji(String text) {
    final pattern = RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

    final matches = pattern.allMatches(text);

    if (matches.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  ///ScrollDown
  void _scrollDown() {
    _scrollcontroller.animateTo(
      _scrollcontroller.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

//Send Message Function

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.reciverUid, _messageController.text.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message Can not be Empty!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reciverEmail),
      ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildMessageInput()],
      ),
    );
  }

//Message List Widger

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.reciverUid, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error')));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          controller: _scrollcontroller,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageitem(doc)).toList(),
        );
      },
    );
  }

//MessageItem Widget

  Widget _buildMessageitem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Directionality(
        textDirection: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  border: Border(
                    left: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    top: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    bottom: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    right: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft:
                          (data['senderId'] == _firebaseAuth.currentUser!.uid)
                              ? Radius.circular(20)
                              : Radius.circular(0),
                      topRight:
                          (data['senderId'] == _firebaseAuth.currentUser!.uid)
                              ? Radius.circular(20)
                              : Radius.circular(20),
                      bottomRight:
                          (data['senderId'] == _firebaseAuth.currentUser!.uid)
                              ? Radius.circular(0)
                              : Radius.circular(20))),

              // alignment: alignment,
              child: Column(
                children: [
                  (data['message'].toString().length == 2 &&
                          isEmoji(data['message'].toString()))
                      ? Text(
                          data['message'].toString(),
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontSize: 25),
                        )
                      : Text(
                          data['message'].toString(),
                          textDirection: TextDirection.ltr,
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//Message Input Widget
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: customTextField(
                  obscureText: false,
                  hintText: 'Enter Message',
                  coltroller: _messageController,
                  iconData: Icons.message)),
          IconButton(
              onPressed: () async {
                sendMessage();
                _messageController.clear();
                _scrollDown();
              },
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
    );
  }
}
