import 'package:doc_scanner/features/chatbot/screens/upload_new_pdf.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const HistoryScreen()),
    );
  }

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Toggle this based on your actual backend/local database check
  bool hasConversations = false;

  // Function to open the Upload screen inside a BottomSheet
  void _openUploadBottomSheet() async {
    final result = await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true, // Allows full screen sizing if needed
      backgroundColor: Colors.transparent, // Keeps rounded corners clean
      builder: (context) {
        return const UploadNewPdfScreen();
      },
    );

    // When the BottomSheet pops back to this screen:
    if (result != null) {
      // Handle the data passed back (e.g., refreshing your conversation list)
      setState(() {
        // Just an example: if a valid PDF path or flag is returned, update state
        hasConversations = true;
      });

      // Print or process your returned props here
      print("Returned data from upload screen: $result");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: hasConversations
          ? _buildHistoryList() // Render your conversation items here
          : _buildEmptyState(),
    );
  }

  // UI Match for your screenshot
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          // Illustration Asset
          Image.asset(
            'assets/noconversation.png',
            height: 220,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 40),
          // Title Text
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              children: [
                TextSpan(text: 'No '),
                TextSpan(
                  text: 'conversations ',
                  style: TextStyle(
                    color: Color(0xFF6366F1),
                  ), // Custom Indigo Accent color
                ),
                TextSpan(text: 'yet'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Subtitle Text
          const Text(
            'Upload a PDF to start chatting\nwith your AI assistant.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
          ),
          const Spacer(flex: 2),
          // Call to Action Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _openUploadBottomSheet,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFF5A67F2,
                ), // Accent Color matching button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Upload a PDF',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return const Center(
      child: Text("Conversation history items list goes here"),
    );
  }
}
