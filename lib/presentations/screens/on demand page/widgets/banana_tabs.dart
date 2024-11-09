import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';

class ProduceStoreTabs extends StatefulWidget {
  const ProduceStoreTabs({super.key});

  @override
  State<ProduceStoreTabs> createState() => _ProduceStoreTabsState();
}

class _ProduceStoreTabsState extends State<ProduceStoreTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Banana', 'Kiwi', 'Avocado', 'Lemon'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: AppText('Produce Store', style: Ts.semiBold20()),
        backgroundColor: AppColor.white,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: const UnderlineTabIndicator(
            insets: EdgeInsets.symmetric(horizontal: 16.0),
            borderSide: BorderSide(
              color: AppColor.primary,
              width: 2.0,
            ),
          ),
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((String tab) {
          return _buildStoreList();
        }).toList(),
      ),
    );
  }

  Widget _buildStoreList() {
    return ListView.builder(
      itemCount: 6, 
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Hbox(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: SizedBox(
                height: screenHeight(context) * 0.3,
                width: double.infinity,
                child: Image.asset(
                  
                  AppImage.bananastore,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Store Name ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text('Location ${index + 1}'),
                      const Spacer(),
                      const Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              Text('4.2'),
                            ],
                          ),
                          Text('15m | 28 min'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}