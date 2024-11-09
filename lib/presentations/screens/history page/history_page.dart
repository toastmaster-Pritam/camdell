import 'package:camdell/meta/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<String> _options = ['Orders', 'Completed', 'Canceled'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Text("History", style: Ts.semiBold20(color: AppColor.white)),
      backIcon: Icons.arrow_back,
      chat: true,
      onBackPressed: () => Get.back(),
      body: Column(
        children: [
          _buildOptionsRow(),
          Expanded(
            child: _buildSelectedContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsRow() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(_options.length, (index) {
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _options[index],
                style: Ts.medium16(
                  color: _selectedIndex == index ? AppColor.black : AppColor.grey,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildOrdersList('Orders');
      case 1:
        return _buildOrdersList('Completed');
      case 2:
        return _buildOrdersList('Canceled');
      default:
        return Container();
    }
  }

  Widget _buildOrdersList(String type) {
    return ListView.builder(
      itemCount: 10, // Replace with actual order count
      itemBuilder: (context, index) => _buildOrderItem(type),
    );
  }

  Widget _buildOrderItem(String type) {
    return Card(
      color: AppColor.white,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                AppImage.man,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Emmanuel Chase', style: Ts.semiBold16()),
                  const SizedBox(height: 4),
                  Text('19 Sep 2024, 08:45 AM', style: Ts.regular14(color: AppColor.grey)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow.shade700, size: 16),
                    const SizedBox(width: 4),
                    Text('5', style: Ts.semiBold14()),
                  ],
                ),
                const SizedBox(height: 4),
                Text('\$300', style: Ts.semiBold16(color: AppColor.green600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}