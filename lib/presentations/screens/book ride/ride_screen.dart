import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/animated_linear_widget.dart';
import 'package:camdell/presentations/widgets/coupon_textfield.dart';
import 'package:camdell/presentations/widgets/open_location_dialog.dart';
import 'package:camdell/presentations/widgets/payment_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripple_wave/ripple_wave.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({super.key});

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  int? _selectedIndex;
  bool _showWidgets = true;
  bool _showRideAnimation = false;
  
  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _checkAndRequestLocationPermission();
  }

  void _showBookingBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText("Fee Breakdown", style: Ts.medium18(color: AppColor.black)),
              const Hbox(20),
              _items("Base Fee", "200"),
              const Hbox(8),
              _items("Rate per km", "20"),
              const Hbox(8),
              _items("Charge per min", "40"),
              const Hbox(8),
              _items("Waiting fee per min", "60"),
              const Hbox(8),
              const Spacer(),
              AppButton(
                bgColor: AppColor.blue900,
                onPressed: () {
                  Navigator.pop(context);
                  _wPaymentBottomSheet();
                  setState(() {
                    _showWidgets = true;
                  });
                },
                text: 'Done',
                elevation: 0,
                isFullWidth: true,
                borderRadius: 20,
                textColor: AppColor.white,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _wPaymentBottomSheet() {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText("Apply Coupon", style: Ts.medium15(color: AppColor.black)),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_rounded, color: AppColor.black, size: 15),
                  ],
                ),
                const Hbox(20),
                CouponCodeWidget(onApply: (code) {
                  print('Applying coupon code: $code');
                }),
                const Hbox(20),
                AppText("Payment Method", style: Ts.medium15(color: AppColor.black)),  
                const Hbox(20),
                const PaymentButton(imagepath: AppImage.visa, cardNumber: '**** **** **** 5678'),
                const Hbox(10),
                 PaymentButton(imagepath: AppImage.mastercard, cardNumber: '**** **** **** 5678',onTap: () => Get.toNamed(AppRoute.cardscreen),),
                const Hbox(10),
                const PaymentButton(imagepath: AppImage.paypal, cardNumber: 'PayPal'),
                const Hbox(10),
                const PaymentButton(imagepath: AppImage.cash, cardNumber: "Cash"),
                const Hbox(20),
                Center(child: _waddpayment()),
                const Hbox(20),
                Center(
                  child: AppButton(
                    bgColor: AppColor.blue900,
                    onPressed: () {
                      Navigator.pop(context);
                       _wBookingConfirm();
                    },
                    text: 'Book Ride',
                    elevation: 0,
                    horizontalPadding: Responsive.doubleR(context, mobile: 60, desktop: 100, tablet: 80),
                    isFullWidth: true,
                    borderRadius: 40,
                    textColor: AppColor.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backIcon: Icons.arrow_back,
      onBackPressed: () => Get.back(),
      showProfile: false,
      title: AppText("Book Ride", style: Ts.semiBold20(color: AppColor.white)),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(AppImage.map, fit: BoxFit.fill),
            if (_showWidgets) ...[
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: Card(
                  elevation: 0,
                  color: AppColor.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildInputField(Icons.location_on, Colors.red, "From:", "Your Location"),
                        const Hbox(5),
                        const Divider(height: 2, thickness: 1, indent: 25),
                        const Hbox(5),
                        _buildInputField(Icons.location_on, Colors.blue, "To:", "East Jefferson Streetside"),
                      ],
                    ),
                  ),
                )
              ),
              Positioned(
                bottom: 80,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    SizedBox(
                      height: Responsive.doubleR(context, mobile: 200, desktop: 400, tablet: 300),
                      width: screenwidth(context),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: Responsive.doubleR(context, mobile: 180, desktop: 250, tablet: 220),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: isSelected ? AppColor.blue900 : AppColor.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText('Mercendz Benz', 
                                    style: Ts.bold16(color: isSelected ? AppColor.white : AppColor.black)),
                                  const Hbox(8),
                                  AppText('DL- 123456', 
                                    style: TextStyle(color: isSelected ? AppColor.white : AppColor.black)),
                                  const Hbox(5),
                                  AppText('3 Person Can ride', 
                                    style: TextStyle(color: isSelected ? AppColor.white : AppColor.black)),
                                  const Hbox(10),
                                  Image.asset(
                                    AppImage.car,
                                    width: Responsive.doubleR(context, mobile: 60, desktop: 60, tablet: 50),
                                    height: Responsive.doubleR(context, mobile: 60, desktop: 60, tablet: 50),
                                  ),
                                  AppText('\$300', 
                                    style: Ts.regular16(color: isSelected ? AppColor.white : AppColor.black)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Hbox(40),
                    AppButton(
                      bgColor: AppColor.blue900,
                      onPressed: () {
                        setState(() {
                          _showWidgets = false;
                        });
                       _showBookingBottomSheet();
                      },
                      text: 'Book Ride',
                      elevation: 0,
                      horizontalPadding: Responsive.doubleR(context, mobile: 60, desktop: 100, tablet: 80),
                      isFullWidth: false,
                      borderRadius: 20,
                      textColor: AppColor.white,
                    ),
                  ],
                ),
              ),
            ],
            if (_showRideAnimation)
              const Center(
                child: RippleWave(
        color: Colors.green,
        repeat: false,
        child: SizedBox.shrink()
      ),
    
              ),
          ],
        ),
      ),
    );
  }

  
void _wBookingConfirm() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 156,
                height: 156,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffB6BFFF),
                ),
                child: Icon(
                  Icons.thumb_up,
                  size: 40,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 16),
              AppText(
                'Thank You !',
                style: GoogleFonts.rubik(
                  fontSize: 38,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Hbox(8),
              Center(
                child: AppText(
                  'Your Ride Booking Successful',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: 20, color: const Color(0xff677294)),
                ),
              ),
              const SizedBox(height: 8),
              AppText(
                'You booked a ride with Purpleson on\nSeptember 21 at 02:00 PM',
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xff677294)),
              ),
              const SizedBox(height: 24),
              AppButton(
                bgColor: AppColor.blue900,
                onPressed: () {
                  Navigator.of(context).pop();
                  _wride();
                },
                text: 'Done',
                elevation: 0,
                horizontalPadding: Responsive.doubleR(context, mobile: 60, desktop: 100, tablet: 80),
                isFullWidth: true,
                borderRadius: 10,
                textColor: AppColor.white,
              ),
              const SizedBox(height: 8),
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
  Widget _items(String title, String amt) {
    return Row(
      children: [
        AppText(title, style: Ts.medium15(color: AppColor.black)),
        const Spacer(),
        AppText("\$$amt", style: Ts.medium15(color: AppColor.grey)),
      ],
    );
  }

  Widget _buildInputField(IconData icon, Color color, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: color),
        const Wbox(4),
        AppText(label, style: Ts.bold16(color: AppColor.black)),
        const Wbox(10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: value,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            style: Ts.regular16(),
          ),
        ), 
      ],
    );
  }

  Future<void> _checkAndRequestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationPermissionDialog();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      _showLocationPermissionDialog();
    }
  }

  void _showLocationPermissionDialog() {
    if (!mounted) return; 
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return LocationPermissionDialog(
          onAllow: () async {
            Navigator.pop(context);
            LocationPermission permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.always || 
                permission == LocationPermission.whileInUse) {
              // Handle successful permission grant
            } else {
              // Handle permission denied
            }
          },
          onDeny: () {
            Navigator.pop(context);
            // Handle permission denied
          },
        );
      },
    );
  }

  Widget _waddpayment() {
    return DottedBorder(
      dashPattern: const [6, 6],
      strokeWidth: 1.5,
      color: Colors.black,
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: AppText(
          '+ Add Payment Method',
          style: Ts.semiBold16()
        ),
      ),
    );
  }

   Future<void> _wride() async {
    setState(() {
      _showWidgets = false;
      _showRideAnimation = true;
    });

    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        // Start a timer to close this bottom sheet and open the driver info after 5 seconds
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pop(context);
          _wDriverInfo();
        });

        return Container(
          height: screenHeight(context) / 2.2,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Center(
            child: Column(
              children: [
                const Hbox(20),
                Image.asset(AppImage.carride, height: 130),
                const Hbox(20),
                AppText("Looking for drivers... ", style: Ts.medium18(color: AppColor.black)),
                const Hbox(10),
                const LinearProgressAnimation(
                  height: 5.0,
                  duration: Duration(seconds: 2),
                ),
                const Hbox(25),
                AppButton(
                  bgColor: AppColor.blue900,
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _showWidgets = true;
                      _showRideAnimation = false;
                    });
                  },
                  text: 'Cancel Ride',
                  elevation: 0,
                  horizontalPadding: Responsive.doubleR(context, mobile: 80, desktop: 100, tablet: 80),
                  isFullWidth: false,
                  borderRadius: 40,
                  textColor: AppColor.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
Future<void> _wDriverInfo() async {
  setState(() {
    _showWidgets = false;
    _showRideAnimation = true;
  });

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.75,
      builder: (_, controller) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 8.0,
                      right: 8.0,
                      bottom: 80.0,
                    ),
                    itemCount: 5,
                    itemBuilder: (_, index) => Column(
                      children: [
                        _driverInfo(),
                        const SizedBox(height: 16)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SafeArea(
              child:AppButton(
                text: "Cancel Ride",
                bgColor: AppColor.blue900,
                elevation: 0,
                borderRadius: 40,
                horizontalPadding: Responsive.doubleR(
                  context,
                  mobile: 80,
                  desktop: 100,
                  tablet: 80,
                ),
                textColor: AppColor.white,
                onPressed: () {},
                isFullWidth: false,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _driverInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
       border: Border.all(color: AppColor.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(AppImage.men),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText("Driver Name", style: Ts.semiBold18()),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            ...List.generate(5, (index) => const Padding(
                              padding: EdgeInsets.only(right: 2),
                              child: Icon(Icons.star, size: 16, color: Colors.amber),
                            )),
                            const SizedBox(width: 4),
                            AppText("(315)", style: Ts.regular14(color: AppColor.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                 GestureDetector(
                   onTap: () =>Get.toNamed(AppRoute.chatdriver),
                   child: CircleAvatar(
                     radius: 25,
                     backgroundColor: AppColor.primary,
                     child: Image.asset(AppImage.msg, height: 20,color: AppColor.white,),
                   ),
                 )
                ],
              ),
              const Hbox(10),
              Row(
                children: [
                  AppText("Mercedes-Benz" , style: Ts.medium16(color: AppColor.black)),
              const Spacer(),
              AppText("Arrived In", style: Ts.medium16(color: AppColor.black)),
               ],
              ),
              const Hbox(5),
              Row(
                children: [
                  AppText("DL-12345678" , style: Ts.regular15(color: AppColor.grey)),
              const Spacer(),
              AppText("10 Min ", style: Ts.regular(color: AppColor.grey)),
               ],
              ),
            
            ],
          ),
          
        ],
      ),
    );
  }

 

 

  
 

 
}