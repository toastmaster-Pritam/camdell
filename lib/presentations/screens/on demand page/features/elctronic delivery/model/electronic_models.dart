import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ElectronicItems extends StatelessWidget {
  final List<ElectronicName> electronicname = [
    ElectronicName(
      name: 'Fan',
      imageUrl: 'assets/images/fan.png',
    ),
    ElectronicName(
      name: 'TV',
      imageUrl: 'assets/images/tv.png',
    ),
    ElectronicName(
      name: 'HeadPhone',
      imageUrl: 'assets/images/headphone.png',
    ),
    ElectronicName(
      name: 'HeadPhone',
      imageUrl: 'assets/images/headphone.png',
    ),
    ElectronicName(
      name: 'Fan',
      imageUrl: 'assets/images/fan.png',
    ),
    ElectronicName(
      name: 'TV',
      imageUrl: 'assets/images/tv.png',
    ),
    ElectronicName(
      name: 'HeadPhone',
      imageUrl: 'assets/images/headphone.png',
    ),
    ElectronicName(
      name: 'HeadPhone',
      imageUrl: 'assets/images/headphone.png',
    ),
  ];
 ElectronicItems({super.key,});


 void _onFruitTap(BuildContext context, int index) {
    final fruit = electronicname[index];
    if (fruit.name.toLowerCase() == 'Fan') {
      Get.toNamed(AppRoute.banana);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You tapped on ${fruit.name} (index: $index)'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: electronicname.length,
      itemBuilder: (context, index) {
        return ElectronicModels(
          electronicName: electronicname[index],
          onTap: ()=> _onFruitTap(context, index),
        );
      },
    );
  }
}


class ElectronicModels extends StatelessWidget {
  final ElectronicName electronicName;
  final VoidCallback onTap;
  const ElectronicModels({super.key, required this.electronicName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(electronicName.imageUrl),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          AppText(
            electronicName.name,
            style: Ts.medium10(color: AppColor.grey),
          ),
        ],
      ),
    );
  }
}

class ElectronicName {
    final String name;
  final String imageUrl;

  ElectronicName({required this.name, required this.imageUrl});
}