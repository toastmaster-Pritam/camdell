import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/profile_txtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SetUpProfilePage extends StatefulWidget {
  const SetUpProfilePage({super.key});

  @override
  State<SetUpProfilePage> createState() => _SetUpProfilePageState();
}

class _SetUpProfilePageState extends State<SetUpProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight(context) * 0.5,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColor.primary,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                child: Padding(padding: const EdgeInsets.all(20),child: Column(
                
                  children: [
                    Row(
                      children: [
                      backButton(),
                      const Spacer(),
                        AppText("Settings",style: Ts.semiBold20(color: AppColor.white),),
                        const Spacer(),
                        const Wbox(30)
                      ],
                    ),
                    const Hbox(15),
                    AppText("Set up your profile",style: GoogleFonts.rubik(color: AppColor.white,fontWeight: FontWeight.w500,fontSize: 16),),
                    const Hbox(15),
                    SizedBox(
                      width: screenwidth(context) * 0.9,
                      child: AppText("Update your profile to connect your Driver s with better impression.",style: GoogleFonts.rubik(color: AppColor.white,fontWeight: FontWeight.w400,fontSize: 16,),textAlign: TextAlign.center,),),
                    const Hbox(40),
                    profilePhoto(AppImage.man, screenwidth(context) * 0.3, () => _showBottomSheet(context),),
                  ],
                ),),
              ),
             Padding(
               padding: const EdgeInsets.all(16),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   AppText("Personal Information",style: GoogleFonts.rubik(color: AppColor.black,fontWeight: FontWeight.w400,fontSize: 16,),textAlign: TextAlign.center,),
                   const Hbox(10),
                  const ProfileTxtfield(label: "Name", ),
                  const Hbox(10),
                   const ProfileTxtfield(label: "Contact Number", showSuffixIcon: true,),
                  const Hbox(10),
                   const ProfileTxtfield(label: "Date of Birth", showSuffixIcon: true,),
                  const Hbox(10),
                   const ProfileTxtfield(label: "Location", ),
                   const Hbox(40),
                    Padding(
               padding: const EdgeInsets.all(20),
               child: AppButton(
                text: "Edit",
                textColor: AppColor.white,
                onPressed: ()=> Get.toNamed(AppRoute.editProfile),
                isFullWidth: true,
               ),
             ),

                 ],
               ),
             ),



         ]
          ))
        ));
  }

    void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppText("Change your Profile photo",style: GoogleFonts.rubik(color: AppColor.black,fontWeight: FontWeight.w500,fontSize: 22,),),
            const Hbox(20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.grey),
              title:  AppText('Take a Photo',style: GoogleFonts.rubik(color: AppColor.black,fontWeight: FontWeight.w400,fontSize: 16,),),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColor.grey),
              title: const Text('Upload from gallery'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget profilePhoto(String imageUrl, double size, VoidCallback onTap) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
       
      ),
      child: Stack(
        children: [
          ClipOval(
            child: Image.asset(
              imageUrl,
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: onTap,
                child: Icon(
                  Icons.camera_alt,
                  color: AppColor.primary,
                  size: size * 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget backButton(){
    return   Container(
        height: 38,
        decoration: const BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.black, size: 24),
            onPressed:()=> Get.back(),
          ),
        ),
      );
  }
}