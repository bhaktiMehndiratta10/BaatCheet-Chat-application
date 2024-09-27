import 'package:baat_cheet/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the current theme is dark mode
    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    // Determine text color based on whether the user is the current user and the theme
    Color textColor = isCurrentUser ? Colors.white : (isDarkMode ? Colors.white : Colors.black);

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500)
            : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(color: textColor), // Use dynamic text color
      ),
    );
  }
}
