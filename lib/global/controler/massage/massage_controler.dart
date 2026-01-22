// lib/global/controller/massage/massage_controller.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/massage/massage_model.dart';
import '../../service/massage/massage_service.dart';

class MessageController extends GetxController {
  // Observable Variables
  final messages = <MessageItem>[].obs;
  final isLoading = false.obs;
  final isSending = false.obs;
  final isLoadingMore = false.obs;

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final hasNextPage = false.obs;

  // Search
  final searchQuery = ''.obs;

  // Selected File
  Rx<File?> selectedFile = Rx<File?>(null);
  Rx<Uint8List?> selectedWebFile = Rx<Uint8List?>(null);
  final selectedFileName = ''.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  /// Load Messages (Initial or Refresh)
  Future<void> loadMessages({bool refresh = false, BuildContext? context}) async {
    if (refresh) {
      currentPage.value = 1;
      messages.clear();
    }

    isLoading.value = true;

    try {
      final response = await MessageService.getMessages(
        pageNumber: currentPage.value,
      );

      if (refresh) {
        messages.value = response.items;
      } else {
        messages.addAll(response.items);
      }

      totalPages.value = response.totalPages;
      hasNextPage.value = response.hasNextPage;

      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Messages loaded successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF5B7FBF),
          ),
        );
      }
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load messages: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Load More Messages (Pagination)
  Future<void> loadMoreMessages({BuildContext? context}) async {
    if (!hasNextPage.value || isLoadingMore.value) return;

    isLoadingMore.value = true;
    currentPage.value++;

    try {
      final response = await MessageService.getMessages(
        pageNumber: currentPage.value,
      );

      messages.addAll(response.items);
      hasNextPage.value = response.hasNextPage;
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load more messages'),
            backgroundColor: Colors.red,
          ),
        );
      }
      currentPage.value--;
    } finally {
      isLoadingMore.value = false;
    }
  }

  /// Send Message
  Future<void> sendMessage({
    required String subject,
    required String body,
    BuildContext? context,
  }) async {
    if (subject.trim().isEmpty || body.trim().isEmpty) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subject and message cannot be empty'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    isSending.value = true;

    try {
      final success = await MessageService.sendMessage(
        subject: subject,
        body: body,
        attachmentFile: selectedFile.value,
        webAttachment: selectedWebFile.value,
      );

      if (success) {
        if (context != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Message sent successfully'),
              backgroundColor: Color(0xFF5B7FBF),
            ),
          );
        }

        // Clear attachment
        clearAttachment();

        // Refresh messages
        await loadMessages(refresh: true, context: context);
      }
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isSending.value = false;
    }
  }

  /// Pick Image from Gallery
  Future<void> pickImage({BuildContext? context}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        if (kIsWeb) {
          selectedWebFile.value = await image.readAsBytes();
          selectedFileName.value = image.name;
        } else {
          selectedFile.value = File(image.path);
          selectedFileName.value = image.name;
        }

        if (context != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Image selected: ${selectedFileName.value}'),
              backgroundColor: const Color(0xFF5B7FBF),
            ),
          );
        }
      }
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Pick File/Document
  Future<void> pickFile({BuildContext? context}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        if (kIsWeb) {
          selectedWebFile.value = file.bytes;
          selectedFileName.value = file.name;
        } else {
          selectedFile.value = File(file.path!);
          selectedFileName.value = file.name;
        }

        if (context != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File selected: ${selectedFileName.value}'),
              backgroundColor: const Color(0xFF5B7FBF),
            ),
          );
        }
      }
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Clear Selected Attachment
  void clearAttachment() {
    selectedFile.value = null;
    selectedWebFile.value = null;
    selectedFileName.value = '';
  }

  /// Search Messages
  void searchMessages(String query) {
    searchQuery.value = query.toLowerCase();
  }

  /// Get Filtered Messages
  List<MessageItem> get filteredMessages {
    if (searchQuery.value.isEmpty) {
      return messages;
    }

    return messages.where((msg) {
      return msg.subject.toLowerCase().contains(searchQuery.value) ||
          msg.body.toLowerCase().contains(searchQuery.value) ||
          msg.posterName.toLowerCase().contains(searchQuery.value);
    }).toList();
  }
}