import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/home%20page/features/buying%20and%20selling/buying%20and%20selling%20widget/banner_shoe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ShowProductWidget extends StatefulWidget {
  const ShowProductWidget({super.key});

  @override
  State<ShowProductWidget> createState() => _ShowProductWidgetState();
}

class _ShowProductWidgetState extends State<ShowProductWidget> {
  double _currentPage = 0;
  final PageController _pageController = PageController();

  final List<String> images = [
    AppImage.shoes,
    AppImage.shoes,
    AppImage.shoes,
    AppImage.shoes,
    AppImage.shoes,
    AppImage.shoes,
    AppImage.shoes,
    AppImage.shoes,
    AppImage.shoes,
    AppImage.shoes,
  ];

    @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screenHeight(context) * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
          ),
         child:  Center(
           child: Column(
             children: [
               Expanded(
                 child: PageView.builder(
                    controller: _pageController,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Image.asset(AppImage.shoes, fit: BoxFit.contain,);  
                 }),
               ),
               const Hbox(10),
                 ExpandableDotIndicator(
          currentPage: _currentPage,
        ),
        const Hbox(10),

             ],
           ),
         ),
        ),
         const Hbox(10),
        Center(
        child: ShoeSelector(
          shoeImages: images,
          onSelect: (index) {
            // Handle selection
            print('Selected shoe index: $index');
          },
        ),
      ),
      const Hbox(10),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText("Nike Shoe", style: Ts.semiBold15(),),
              const Hbox(5),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 18, ),
                  const Wbox(4),
                  AppText("3.5", style: Ts.semiBold10(color: AppColor.grey),),
                ],
              ),
              
            ],
          ),
          const Spacer(),
          AppText("\$300", style: Ts.semiBold13(color: AppColor.grey),),

        ],
      ),
      const Hbox(10),
      AppText("Select Size", style: Ts.semiBold15(),),
      const Hbox(10),
      Row(
        children: List.generate(6, (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(

            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.gray100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: AppText("4$index", style: Ts.semiBold15(),),
            ),
          ),
        ))
      ),
      const Hbox(10),
        AppButton(
          text: "Buy Now",
          textColor: AppColor.white,
          horizontalPadding: 40,
          onPressed: ()=> Get.toNamed(AppRoute.cart),
        ),

        // Row(
        //   children:
        // List.generate(6, (index) => Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20),
        //     border: Border.all(color: Colors.grey),
        //     image: const DecorationImage(image: AssetImage(AppImage.shoes), fit: BoxFit.cover,),
        //   ),
        // )))
      ],
    );
  }
}


class ShoeSelector extends StatefulWidget {
  final List<String> shoeImages;
  final Function(int) onSelect;

  const ShoeSelector({
    super.key,
    required this.shoeImages,
    required this.onSelect,
  });

  @override
  State<ShoeSelector> createState() => _ShoeSelectorState();
}

class _ShoeSelectorState extends State<ShoeSelector> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.shoeImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onSelect(index);
            },
            child: Container(
              height: 80,
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedIndex == index
                      ? AppColor.primary
                      : Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.shoeImages[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
