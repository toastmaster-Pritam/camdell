import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/constants/app_text.dart';
import '../../../core/route/routes.dart';
import '../../../meta/utils/ts.dart';

class Message {
  final String name;
  final String message;
  final String timeAgo;
  final String avatarUrl;
  final bool isUnread;

  Message({
    required this.name,
    required this.message,
    required this.timeAgo,
    required this.avatarUrl,
    required this.isUnread,
  });
}

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({super.key});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
   final TextEditingController _searchController = TextEditingController();
  bool _showUnreadOnly = false;
  final List<Message> messages = [
    Message(
      name: 'James Brown',
      message: 'Where are you?',
      timeAgo: '5 min ago',
      avatarUrl: AppImage.men,
      isUnread: true,
    ),
    Message(
      name: 'Chandler Bing',
      message: 'Where are you?',
      timeAgo: '10 min ago',
      avatarUrl: AppImage.men,
      isUnread: true,
    ),
    Message(
      name: 'Joey Tribbiani',
      message: 'Where are you?',
      timeAgo: '50 min ago',
      avatarUrl: AppImage.men,
      isUnread: false,
    ),
    Message(
      name: 'Ross Geller',
      message: 'Where are you?',
      timeAgo: '1 hr ago',
      avatarUrl: AppImage.men,
      isUnread: false,
    ),
    Message(
      name: 'Albert Walls',
      message: 'Where are you?',
      timeAgo: '2 hrs ago',
      avatarUrl: AppImage.men,
      isUnread: false,
    ),
    Message(
      name: 'George Mike',
      message: 'Where are you?',
      timeAgo: '5 hrs ago',
      avatarUrl: AppImage.men,
      isUnread: false,
    ),
    Message(
      name: 'Mickeal Johnson',
      message: 'Where are you?',
      timeAgo: '1 day ago',
      avatarUrl: AppImage.men,
      isUnread: false,
    ),
  ];

  List<Message> get filteredMessages {
    final searchQuery = _searchController.text.toLowerCase();
    return messages.where((message) {
      final matchesSearch = message.name.toLowerCase().contains(searchQuery) ||
          message.message.toLowerCase().contains(searchQuery);
      final matchesFilter = !_showUnreadOnly || message.isUnread;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() {}),
                    decoration: const InputDecoration(
                      hintText: 'Search for chat',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter Buttons
                Row(
                  children: [
                    _FilterButton(
                      text: 'All',
                      isSelected: !_showUnreadOnly,
                      onTap: () => setState(() => _showUnreadOnly = false),
                    ),
                    const SizedBox(width: 8),
                    _FilterButton(
                      text: 'Unread',
                      isSelected: _showUnreadOnly,
                      onTap: () => setState(() => _showUnreadOnly = true),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: filteredMessages.length,
              itemBuilder: (context, index) {
                final message = filteredMessages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.chatdriver),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: AssetImage(message.avatarUrl),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                message.name,
                                style: TextStyle(
                                  fontWeight: message.isUnread
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              message.timeAgo,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            message.message,
                            style: TextStyle(
                              color: message.isUnread
                                  ? Colors.black87
                                  : Colors.grey[600],
                              fontWeight: message.isUnread
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        onTap: () => Get.toNamed(AppRoute.chatdriver),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// Filter Button Widget
class _FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.grey : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColor.grey,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppText(
        "Chat",
        style: Ts.semiBold20(color: AppColor.white),
      ),
      chat: false,
      backIcon: Icons.arrow_back,
      onBackPressed: () => Get.back(),
      body: const Center(
        child: ChatListWidget(),
      ),
    );
  }
}