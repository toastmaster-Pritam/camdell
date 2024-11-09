import 'package:flutter/material.dart';

class MessageTypeField extends StatefulWidget {
  final Function(String)? onMessageSent;

  const MessageTypeField({super.key, this.onMessageSent});

  @override
  State<MessageTypeField> createState() => _MessageTypeFieldState();
}

class _MessageTypeFieldState extends State<MessageTypeField> {
  final TextEditingController _controller = TextEditingController();
  bool _showSendButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _showSendButton = _controller.text.trim().isNotEmpty;
    });
  }

  void _handleSubmit() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onMessageSent?.call(_controller.text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Fixed height
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Emoji Button
          SizedBox(
            width: 40,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.emoji_emotions_outlined, size: 24),
              color: Colors.grey[600],
              onPressed: () {},
            ),
          ),
          // Text Field
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
          // Send/Mic Button
          SizedBox(
            width: 40,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                _showSendButton ? Icons.send : Icons.mic_outlined,
                size: 24,
              ),
              color: _showSendButton 
                  ? Theme.of(context).primaryColor 
                  : Colors.grey[600],
              onPressed: _showSendButton ? _handleSubmit : () {},
            ),
          ),
        ],
      ),
    );
  }
}