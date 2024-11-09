import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Efavorite extends StatefulWidget {
  const Efavorite({super.key});

  @override
  State<Efavorite> createState() => _EfavoriteState();
}

class _EfavoriteState extends State<Efavorite> {
  final List<Map<String, String>> movies = [
     {
      'title': 'Deadpool',
      'description': 'The latest MCU movie, its success at the box office has helped the X-Men.',
      'imageUrl': AppImage.deadpool,
    },
     {
      'title': 'Deadpool',
      'description': 'The latest MCU movie, its success at the box office has helped the X-Men.',
      'imageUrl': AppImage.deadpool4,
    },
     {
      'title': 'Deadpool',
      'description': 'The latest MCU movie, its success at the box office has helped the X-Men.',
      'imageUrl': AppImage.deadpool2,
    },
     {
      'title': 'Deadpool',
      'description': 'The latest MCU movie, its success at the box office has helped the X-Men.',
      'imageUrl': AppImage.deadpool3,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backIcon: Icons.arrow_back,
      onBackPressed: () => Get.back(),
      title: AppText("Favorite", style: Ts.semiBold20(color: AppColor.white)),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: screenwidth(context),
          height: screenHeight(context),
          child: _listMovies()),
      ),
      );}
      Widget _listMovies() {
        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 18),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.asset(
                  movies[index]['imageUrl']!,
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movies[index]['title']!,
                      style: Ts.semiBold16(color: AppColor.black),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      movies[index]['description']!,
                      style: Ts.semiBold10(color: AppColor.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  
      }
      
      }