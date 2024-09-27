import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text; // User email to be displayed
  final void Function()? onTap; // Function to call when tapped

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine text color based on theme brightness
    final Color textColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black // Black text for light mode
        : Colors.white; // White text for dark mode

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20), // Make padding constant
        child: Row(
          children: [
            // Icon
            const Icon(Icons.person),
            const SizedBox(width: 20),
            // User email
            Text(
              text, // Display the user's email
              style: TextStyle(
                fontSize: 16, // You can adjust the font size
                color: textColor, // Use dynamic text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
