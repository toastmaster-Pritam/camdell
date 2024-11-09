import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class FlowerItems extends StatelessWidget {
  final List<FlowerName> flowername = [
    FlowerName(
      name: 'Rose',
      imageUrl: 'assets/images/rose.png',
    ),
    FlowerName(
      name: 'Sunflower',
      imageUrl: 'assets/images/sunflower.png',
    ),
    FlowerName(
      name: 'Carnation',
      imageUrl: 'assets/images/Carnation.png',
    ),
    FlowerName(
      name: 'Sunflower',
      imageUrl: 'assets/images/sunflower.png',
    ),
     FlowerName(
      name: 'Rose',
      imageUrl: 'assets/images/rose.png',
    ),   FlowerName(
      name: 'Rose',
      imageUrl: 'assets/images/rose.png',
    ),   FlowerName(
      name: 'Rose',
      imageUrl: 'assets/images/rose.png',
    ),   FlowerName(
      name: 'Rose',
      imageUrl: 'assets/images/rose.png',
    ),   FlowerName(
      name: 'Rose',
      imageUrl: 'assets/images/rose.png',
    ),
  ];
 FlowerItems({super.key,});


 void _onFruitTap(BuildContext context, int index) {
    final fruit = flowername[index];
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
      itemCount: flowername.length,
      itemBuilder: (context, index) {
        return ElectronicModels(
          flowerName: flowername[index],
          onTap: ()=> _onFruitTap(context, index),
        );
      },
    );
  }
}


class ElectronicModels extends StatelessWidget {
  final FlowerName flowerName;
  final VoidCallback onTap;
  const ElectronicModels({super.key, required this.flowerName, required this.onTap});

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
                  image: AssetImage(flowerName.imageUrl),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          AppText(
            flowerName.name,
            style: Ts.medium10(color: AppColor.grey),
          ),
        ],
      ),
    );
  }
}

class FlowerName {
    final String name;
  final String imageUrl;

  FlowerName({required this.name, required this.imageUrl});
}