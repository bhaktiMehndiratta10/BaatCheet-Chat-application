import 'package:baat_cheet/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // Get instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map(((snapshot) {
      return snapshot.docs.map((doc) {
        // Go through each individual user
        final user = doc.data();
        // Return user
        return user;
      }).toList();
    }));
  }

  // Send messages
  Future<void> sendMessage(String receiverID, String message) async {
    // Get current user info
    final String currentUserID = _auth.currentUser!.uid;   // Corrected variable naming
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Create a new message object (assuming Message class exists)
    Message newMessage = Message(
      senderID: currentUserID,              // Corrected field name to senderID
      senderEmail: currentUserEmail,        // Corrected to use user email
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,                 // Ensure this matches the Message constructor
    );

    // Construct chat room ID for 2 users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];   // Fixed variable naming
    ids.sort();   // Sort the IDs to ensure uniqueness and consistency in chat room creation
    String chatRoomID = ids.join('_');

    // Add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // Get messages
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    // Construct a chat room ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();   // Ensure the IDs are sorted
    String chatRoomID = ids.join('_');

    // Return message stream ordered by timestamp
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
