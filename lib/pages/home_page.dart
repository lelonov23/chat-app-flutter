import 'package:app/components/user_tile.dart';
import 'package:app/pages/chat_page.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/components/my_drawer.dart';
import 'package:app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        foregroundColor: Colors.grey,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }


  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(), 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      }
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["username"],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverUsername: userData["username"],
              receiverID: userData["uid"],
            ),
          )
        ),
      );
    }
    else {
      return Container();
    }
  }
}