// lib/presentation/screens/massage_screen/massage_screen.dart

import 'package:flutter/material.dart';
import '../../widgets/custom_navigation/custom_navbar.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final font = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Message Board',
          style: TextStyle(
            fontSize: 18 * font,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildUserMessage(
                  width: width,
                  message:
                  "Hi Coach, I've uploaded my passport today. Can you confirm if it was submitted correctly?",
                  time: '05 SEP 2025 @ 12:58 PDT',
                  hasAttachment: true,
                ),
                const SizedBox(height: 16),
                _buildCoachMessage(
                  width: width,
                  message:
                  "Hi, I've checked your documents. Your passport has been successfully submitted.",
                  time: '05 SEP 2025 @ 13:01 PDT',
                  sender: 'Lindsey Heben - Coach',
                ),
                const SizedBox(height: 16),
                _buildUserMessage(
                  width: width,
                  message:
                  "I'm not sure which documents are still pending. Could you guide me?",
                  time: '05 SEP 2025 @ 13:02 PDT',
                ),
                const SizedBox(height: 16),
                _buildOtherMessage(
                  width: width,
                  message:
                  "Hi, I've checked your documents. Your passport has been successfully submitted.",
                  time: '05 SEP 2025 @ 13:05 PDT',
                  sender: 'John Doe - Rotary',
                ),
              ],
            ),
          ),
          _buildMessageInput(width),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 3),
    );
  }

  // ---------------------------------------------------------
  // USER MESSAGE (RIGHT SIDE)
  // ---------------------------------------------------------

  Widget _buildUserMessage({
    required double width,
    required String message,
    required String time,
    bool hasAttachment = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width * 0.75),
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: Color(0xFF5B7FBF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(6),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
              if (hasAttachment) ...[
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.attach_file, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Attachment: UUID',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'View Attachment',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        )
      ],
    );
  }

  // ---------------------------------------------------------
  // COACH MESSAGE (LEFT SIDE - GREY)
  // ---------------------------------------------------------

  Widget _buildCoachMessage({
    required double width,
    required String message,
    required String time,
    required String sender,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width * 0.75),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(6),
            ),
          ),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              sender,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // OTHER MESSAGE (GREEN)
  // ---------------------------------------------------------

  Widget _buildOtherMessage({
    required double width,
    required String message,
    required String time,
    required String sender,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width * 0.75),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(6),
            ),
          ),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              sender,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // MESSAGE INPUT BOX
  // ---------------------------------------------------------

  Widget _buildMessageInput(double width) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message here...',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Icon(Icons.attach_file,
                      color: Color(0xFF5B7FBF), size: 22),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF5B7FBF),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 22),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
