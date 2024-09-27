import 'package:baat_cheet/components/user_tile.dart';
import 'package:baat_cheet/pages/chat_page.dart';
import 'package:baat_cheet/services/auth/auth_service.dart';
import 'package:baat_cheet/components/my_drawer.dart';
import 'package:baat_cheet/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // Build a list of users except for the currently logged-in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Error handling
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }

        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If data is available, return the ListView
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
          );
        } else {
          return const Center(child: Text("No users available"));
        }
      },
    );
  }

  // Build an individual list tile for a user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // Display all users except the current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"], // Display the user's email
        onTap: () {
          // Tapped on a user -> go to chat page
          print("Navigating to chat with: ${userData["email"]}"); // Debugging line
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"], // Pass the email
                receiverID: userData["uid"],       // Pass the user ID
              ),
            ),
          );
        },
      );
    } else {
      return Container();  // Return an empty Container for the current user
    }
  }
}
