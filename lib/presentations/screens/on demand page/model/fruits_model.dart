import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FruitGridView extends StatelessWidget {
  final List<FruitItem> fruits = [
    FruitItem(name: 'Banana', imageUrl: AppImage.banana),
    FruitItem(name: 'Lemon', imageUrl: AppImage.lemon),
    FruitItem(name: 'Kiwi', imageUrl: AppImage.kiwi),
    FruitItem(name: 'Fruits', imageUrl: AppImage.fruits),
    FruitItem(name: 'Banana', imageUrl: AppImage.banana),
    FruitItem(name: 'Lemon', imageUrl: AppImage.lemon),
    FruitItem(name: 'Kiwi', imageUrl: AppImage.kiwi),
    FruitItem(name: 'Fruits', imageUrl: AppImage.fruits),
  ];

  FruitGridView({super.key});

  void _onFruitTap(BuildContext context, int index) {
    final fruit = fruits[index];
    if (fruit.name.toLowerCase() == 'banana') {
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
      itemCount: fruits.length,
      itemBuilder: (context, index) {
        return FruitGridItem(
          fruit: fruits[index],
          onTap: () => _onFruitTap(context, index),
        );
      },
    );
  }
}

class FruitGridItem extends StatelessWidget {
  final FruitItem fruit;
  final VoidCallback onTap;

  const FruitGridItem({super.key, required this.fruit, required this.onTap});

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
                  image: AssetImage(fruit.imageUrl),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            fruit.name,
            style: Ts.medium10(color: AppColor.grey),
          ),
        ],
      ),
    );
  }
}

class FruitItem {
  final String name;
  final String imageUrl;

  FruitItem({required this.name, required this.imageUrl});
}