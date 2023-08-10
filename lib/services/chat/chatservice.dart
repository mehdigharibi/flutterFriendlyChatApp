import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffriendlychat/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatSerive extends ChangeNotifier {
//create Instance of FireBaseauth And FireStore

  final FirebaseAuth _fireBaseauth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

//Send Message

  Future<void> sendMessage(String reciverId, String message) async {
//get current user information

    final String currentUserId = _fireBaseauth.currentUser!.uid;
    final String currentUserEmail = _fireBaseauth.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();

//create new Message
    final Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        reciverId: reciverId,
        message: message,
        timeStamp: timeStamp);

//create chat room Between users
    List<String> chatIds = [currentUserId, reciverId];

    chatIds.sort();
    final String chatRoomId = chatIds.join('_');

//add message to chatroom

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

//Get Messages

  Stream<QuerySnapshot> getMessages(String userId, String partnerUserId) {
    //consturct the chatroomId
    List<String> ids = [userId, partnerUserId];
    ids.sort();
    final String chatRoom = ids.join('_');

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoom)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
