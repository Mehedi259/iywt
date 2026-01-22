// lib/presentation/screens/massage_screen/massage_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/custom_assets/assets.gen.dart';
import '../../../global/controler/massage/massage_controler.dart';
import '../../widgets/custom_navigation/custom_navbar.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final MessageController _controller = Get.put(MessageController());
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _controller.loadMoreMessages(context: context);
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        _searchController.clear();
        _controller.searchMessages('');
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message cannot be empty'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Directly send with subject = "Message"
    _controller.sendMessage(
      subject: 'Message',
      body: _messageController.text.trim(),
      context: context,
    );

    _messageController.clear();
  }

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
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              _controller.pickImage(context: context);
            },
            child: Container(
              height: 53.5,
              padding: const EdgeInsets.symmetric(horizontal: 19.71),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Assets.images.uploadImageIcon.image(
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Upload an image',
                    style: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 1, color: Colors.grey.shade300),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              _controller.pickFile(context: context);
            },
            child: Container(
              height: 52.5,
              padding: const EdgeInsets.symmetric(horizontal: 18.37),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Assets.images.uploadAttachmentIcon.image(
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Upload an attachment',
                    style: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
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

  Future<void> _downloadAttachment(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open attachment'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy @ HH:mm').format(dateTime);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
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
            icon: Assets.images.massageBoardSearchIcon.image(
              width: 24,
              height: 24,
            ),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearchVisible)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _controller.searchMessages(value),
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
            ),
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value && _controller.messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final messages = _controller.filteredMessages;

              if (messages.isEmpty) {
                return const Center(
                  child: Text('No messages found'),
                );
              }

              return RefreshIndicator(
                onRefresh: () => _controller.loadMessages(
                  refresh: true,
                  context: context,
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length +
                      (_controller.isLoadingMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final message = messages[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: message.isFromStudent
                          ? _buildUserMessage(
                        width: width,
                        message: message,
                      )
                          : _buildCoachMessage(
                        width: width,
                        message: message,
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          Obx(() {
            if (_controller.selectedFileName.value.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.all(8),
                color: Colors.blue.shade50,
                child: Row(
                  children: [
                    const Icon(Icons.attach_file, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _controller.selectedFileName.value,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: _controller.clearAttachment,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          _buildMessageInput(width),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 3),
    );
  }

  Widget _buildUserMessage({
    required double width,
    required message,
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
              HtmlWidget(
                message.body,
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
              if (message.hasAttachment) ...[
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _downloadAttachment(message.attachment!),
                  child: const Row(
                    children: [
                      Icon(Icons.attach_file, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'View Attachment',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _formatTime(message.messageDate),
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildCoachMessage({
    required double width,
    required message,
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
          child: HtmlWidget(
            message.body,
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Flexible(
              child: Text(
                message.posterName,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _formatTime(message.messageDate),
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    );
  }

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
          Obx(() {
            return Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF5B7FBF),
                shape: BoxShape.circle,
              ),
              child: _controller.isSending.value
                  ? const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
                  : IconButton(
                icon: Assets.images.sendIcon.image(
                  width: 30,
                  height: 30,
                ),
                onPressed: _sendMessage,
              ),
            );
          }),
        ],
      ),
    );
  }
}