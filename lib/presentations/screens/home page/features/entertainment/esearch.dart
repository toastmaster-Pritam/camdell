import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:camdell/presentations/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class Esearch extends StatefulWidget {
  const Esearch({super.key});

  @override
  State<Esearch> createState() => _EsearchState();
}

class _EsearchState extends State<Esearch> {

  final List imageposter = [
    AppImage.deadpool,
    AppImage.deadpool2,
    AppImage.deadpool3,
    AppImage.deadpool4,
    AppImage.deadpool,
    AppImage.deadpool2,
    AppImage.deadpool3,
    AppImage.deadpool4,
    AppImage.deadpool,
    AppImage.deadpool2,
    AppImage.deadpool3,
    AppImage.deadpool4,
    AppImage.deadpool,
    AppImage.deadpool2,
    AppImage.deadpool3,
    AppImage.deadpool4,
  ];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: AppText("", style: Ts.semiBold20(color: AppColor.white),), body:SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Hbox(10),
          esearch(),
          const Hbox(10),
          SizedBox(
            height: screenHeight(context),
            child: 
          GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1,crossAxisSpacing: 10,mainAxisSpacing: 10),
          itemCount: imageposter.length,
           itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage(imageposter[index]),fit: BoxFit.cover)
              ),
       
            );
          }))
        ],
      ),
    ));
  }


  Widget esearch() {
    return AppTextField(
      hintText: "Sci Fi Movies",
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}