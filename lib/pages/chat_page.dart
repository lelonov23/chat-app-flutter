import 'package:app/components/chat_bubble.dart';
import 'package:app/components/my_textfield.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverUsername;
  final String receiverID;

  ChatPage({
    super.key, 
    required this.receiverUsername, 
    required this.receiverID
  });

  final TextEditingController _msgController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_msgController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _msgController.text);
      _msgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverUsername),
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),

          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderID, receiverID), 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data["senderID"] == _authService.getCurrentUser()!.uid;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(msg: data["message"], isCurrentUser: isCurrentUser)
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Expanded(child: MyTextfield(
            hintText: "Message", 
            obscureText: false, 
            controller: _msgController)
          ),
      
          Container(
            decoration: BoxDecoration(
              color: Colors.green.shade300,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: sendMessage, 
              icon: Icon(
                Icons.arrow_upward,
                size: 35,
                color: Colors.white,
              )
            ),
          )
        ]
      ),
    );
  }
}