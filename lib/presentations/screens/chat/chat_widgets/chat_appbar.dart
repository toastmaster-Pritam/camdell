import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../meta/utils/app_color.dart';
import '../../../../meta/utils/image_constant.dart';
import '../../../../meta/utils/ts.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final VoidCallback? onVideoCall;
  final VoidCallback? onVoiceCall;
  final String? userAvatar;

  const ChatAppBar({
    super.key,
    required this.userName,
    this.onVideoCall,
    this.onVoiceCall,
    this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            // User Avatar
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage(AppImage.man),
            ),
            
            // User Name and Status
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      userName,
                      style: Ts.semiBold14(color: AppColor.black),
                    ),
                  ],
                ),
              ),
            ),
            
            // Video Call, Voice Call, More Options
            _buildActionButton(
              icon: Icons.videocam_outlined,
              onPressed: onVideoCall,
            ),
            _buildActionButton(
              icon: Icons.call,
              onPressed: onVoiceCall,
            ),
            _buildMoreOptionsButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return IconButton(
      icon: Icon(icon, color: Colors.black, size: 22),
      onPressed: onPressed,
    );
  }

  Widget _buildMoreOptionsButton(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColor.white,
      icon: const Icon(Icons.more_vert, color: Colors.black, size: 22),
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        _buildPopupMenuItem('View Contact',),
        _buildPopupMenuItem('Block', ),
        _buildPopupMenuItem('Report', ),
        _buildPopupMenuItem('Mute notifications', ),
        _buildPopupMenuItem('Search',),
      ],
        onSelected: (String result) {
        if (result == 'report') {
          _showReportDialog(context, userName);
        }
        if (result == 'block') {
          _showBlockDialog(context, userName);
        }
        }
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String title,) {
    return PopupMenuItem<String>(
      value: title.toLowerCase().replaceAll(' ', '_'),
      
      child: Text(title),
    );
  }

  void _showReportDialog(BuildContext context, String userName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
       bool isChecked = false;
      return AlertDialog(
        title: Text('Report $userName?',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The last 5 messages from the contact will be forwarded to CAMDELL. If you block this contact and delete the chat, messages will only be removed from this device and your devices on the newer versions of CAMDELL.',
              style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            const Text(
              'This contact will not be notified.',
              style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
               Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
          
              isChecked = value ?? false;
         
          },
        ),
        if (isChecked)
          const Icon(
            Icons.check, // This is the tick icon
            size: 40,
            color: Colors.green, // You can change the color and size as needed
          ),
      ],
    ),
                const Text('Block contact and delete chat',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: AppColor.primarytext),),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Report',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: AppColor.primarytext),),
            onPressed: () {
              // Handle report action
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  void _showBlockDialog(BuildContext context, String userName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
       bool isChecked = false;
      return AlertDialog(
        title: Text('Block $userName?',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The last 5 messages from the contact will be forwarded to CAMDELL. If you block this contact and delete the chat, messages will only be removed from this device and your devices on the newer versions of CAMDELL.',
              style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            const Text(
              'This contact will not be notified.',
              style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
               Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
          
              isChecked = value ?? false;
         
          },
        ),
        if (isChecked)
          const Icon(
            Icons.check, // This is the tick icon
            size: 40,
            color: Colors.green, // You can change the color and size as needed
          ),
      ],
    ),
                const Text('Block contact and delete chat',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: AppColor.primarytext),),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Report',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: AppColor.primarytext),),
            onPressed: () {
              // Handle report action
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}