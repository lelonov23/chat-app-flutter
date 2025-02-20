import 'package:app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String msg;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.msg,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isCurrentUser 
          ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500)
          : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Text(
        msg,
        style: TextStyle(
          color: (isDarkMode ? Colors.white : Colors.black),
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}