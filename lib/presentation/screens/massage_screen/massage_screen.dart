// lib/presentation/screens/massage_screen/massage_screen.dart

import 'package:flutter/material.dart';
import '../../../core/custom_assets/assets.gen.dart';
import '../../widgets/custom_navigation/custom_navbar.dart';
import 'package:image_picker/image_picker.dart';

// Message Model
class Message {
  final String message;
  final String time;
  final MessageType type;
  final String? sender;
  final bool hasAttachment;

  Message({
    required this.message,
    required this.time,
    required this.type,
    this.sender,
    this.hasAttachment = false,
  });
}

enum MessageType { user, coach, other }

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  final ImagePicker _picker = ImagePicker();

  late AnimationController _searchAnimationController;
  late Animation<double> _searchAnimation;
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    // Initial messages load
    _loadInitialMessages();

    // Search Animation Setup
    _searchAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _searchAnimation = CurvedAnimation(
      parent: _searchAnimationController,
      curve: Curves.easeInOut,
    );
  }

  void _loadInitialMessages() {
    _messages.addAll([
      Message(
        message: "Hi Coach, I've uploaded my passport today. Can you confirm if it was submitted correctly?",
        time: '05 SEP 2025 @ 12:58 PDT',
        type: MessageType.user,
        hasAttachment: true,
      ),
      Message(
        message: "Hi, I've checked your documents. Your passport has been successfully submitted.",
        time: '05 SEP 2025 @ 13:01 PDT',
        type: MessageType.coach,
        sender: 'Lindsey Heben - Coach',
      ),
      Message(
        message: "I'm not sure which documents are still pending. Could you guide me?",
        time: '05 SEP 2025 @ 13:02 PDT',
        type: MessageType.user,
      ),
      Message(
        message: "Hi, I've checked your documents. Your passport has been successfully submitted.",
        time: '05 SEP 2025 @ 13:05 PDT',
        type: MessageType.other,
        sender: 'John Doe - Rotary',
      ),
    ]);
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (_isSearchVisible) {
        _searchAnimationController.forward();
      } else {
        _searchAnimationController.reverse();
        _searchController.clear();
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        Message(
          message: _messageController.text.trim(),
          time: _getCurrentTime(),
          type: MessageType.user,
        ),
      );
      _messageController.clear();
    });

    // Scroll to bottom after sending message
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    final day = now.day.toString().padLeft(2, '0');
    final month = months[now.month - 1];
    final year = now.year;
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$day $month $year @ $hour:$minute PDT';
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // Show Attachment Options Popup
  void _showAttachmentOptions(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: _buildAttachmentPopup(context),
        );
      },
    );
  }

// Attachment Popup Widget
  Widget _buildAttachmentPopup(BuildContext context) {
    return Container(
      width: 238,
      height: 107,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Upload Image Option
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              await _pickImage();
            },
            child: Container(
              height: 53.5,
              padding: const EdgeInsets.symmetric(horizontal: 19.71),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: Assets.images.uploadImageIcon.image(width: 24, height: 24),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Upload an image',
                    style: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.32,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider
          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
          // Upload Attachment Option
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              await _pickFile();
            },
            child: Container(
              height: 52.5,
              padding: const EdgeInsets.symmetric(horizontal: 18.37),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: Assets.images.uploadAttachmentIcon.image(width: 24, height: 24),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Upload an attachment',
                    style: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Pick Image from Gallery
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // Handle image upload
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image selected: ${image.name}'),
            backgroundColor: const Color(0xFF5B7FBF),
          ),
        );
        // You can add logic to send image message here
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  // Pick File/Document
  Future<void> _pickFile() async {
    try {
      // For file picker, you'll need file_picker package
      // For now showing a message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File picker functionality - Add file_picker package'),
          backgroundColor: Color(0xFF5B7FBF),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick file')),
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    _searchAnimationController.dispose();
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
            icon: Assets.images.massageBoardSearchIcon.image(width: 24, height: 24),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];

                switch (message.type) {
                  case MessageType.user:
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildUserMessage(
                        width: width,
                        message: message.message,
                        time: message.time,
                        hasAttachment: message.hasAttachment,
                      ),
                    );
                  case MessageType.coach:
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildCoachMessage(
                        width: width,
                        message: message.message,
                        time: message.time,
                        sender: message.sender ?? 'Coach',
                      ),
                    );
                  case MessageType.other:
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildOtherMessage(
                        width: width,
                        message: message.message,
                        time: message.time,
                        sender: message.sender ?? 'Other',
                      ),
                    );
                }
              },
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
                const Row(
                  children: [
                    SizedBox(width: 4),
                    Text(
                      '📎Attachment: UUID',
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
            if (hasAttachment) ...[
              const SizedBox(width: 8),
              Text(
                'View Attachment',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ],
        ),
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
                      onSubmitted: (_) => _sendMessage(),
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
                  GestureDetector(
                    onTap: () => _showAttachmentOptions(context),
                    child: Assets.images.clip.image(
                      width: 22,
                      height: 22,
                      color: const Color(0xFF5B7FBF),
                    ),
                  ),
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
              icon: Assets.images.sendIcon.image(width: 30, height: 30),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}