import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';

class StoreListView extends StatelessWidget {
  final List<Stores> stores;
  const StoreListView({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: stores.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(width: screenwidth(context) * 0.01),
      itemBuilder: (context, index) {
        final store = stores[index];
        return SizedBox(
          width: screenwidth(context) * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 29 / 33,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(store.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.01),
              AppText(
                store.name,
                style: Ts.medium15()
              ),
              AppText(store.location, style: Ts.medium13(color: AppColor.gray500)),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: screenwidth(context) * 0.04),
                  SizedBox(width: screenwidth(context) * 0.01),
                  AppText('${store.rating} | ${store.time}', style: Ts.medium13()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class Stores {
  final String name;
  final String location;
  final String rating;
  final String time;
  final String image;

  Stores({
    required this.name,
    required this.location,
    required this.rating,
    required this.time,
    required this.image,
  });
}