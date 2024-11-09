import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallingScreen extends StatefulWidget {

  const CallingScreen({
    super.key,
  });

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  final String callerName = 'John Doe';
  final String callerimage =  "https://media.istockphoto.com/id/1399565382/photo/young-happy-mixed-race-businessman-standing-with-his-arms-crossed-working-alone-in-an-office.webp?a=1&b=1&s=612x612&w=0&k=20&c=jdNlxvWfyg_3TeA9YIc5g-bySd-gedAdnifCMFUvNII=";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with overlay
          Image.network(
            callerimage,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
              // Caller info
                Positioned(
                  top: 100,
                  left: 160,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(callerimage),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Jon Snow",
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ringing...',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                
              Positioned(
      left: 180, // Adjust this to move horizontally
      bottom: 60, // Adjust this to move vertically
      child: CircleAvatar(
        radius: 30, // Adjust the size of the circular button
        backgroundColor: Colors.red,
        child: IconButton(
          icon: const Icon(Icons.call_outlined, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
    ),
              ],
            ),
   


    );
  }
}