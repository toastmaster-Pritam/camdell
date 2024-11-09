

import 'package:camdell/presentations/screens/chat/chat_widgets/chat_appbar.dart';
import 'package:camdell/presentations/screens/chat/chat_widgets/message.dart';
import 'package:flutter/material.dart';
import '../../../meta/utils/image_constant.dart';
import '../../widgets/app_scaffold.dart';

class DriverChatScreen extends StatelessWidget {
  const DriverChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: const Text(""),
      body: Column(
        children: [
    const ChatAppBar(userName: "John Doe",),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDateHeader("Today"),
                _buildReceivedMessage("I am on my way to pick you up"),
                _buildSentMessage("Yeah I am here!"),
                _buildSentMessage("My Pleasure"),
                _buildImageMessage(context),
                _buildSentMessage("I am waiting for you at here bro"),
                _buildReceivedMessage("See you soon!!"),
              ],
            ),
          ),
           const MessageTypeField()
        ],
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          date,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildSentMessage(String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blue[700],
         borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20)
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildReceivedMessage(String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(message),
      ),
    );
  }

  Widget _buildImageMessage(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AppImage.massage,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  

}


