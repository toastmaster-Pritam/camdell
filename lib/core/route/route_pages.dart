import 'package:camdell/core/route/routes.dart';
import 'package:camdell/presentations/screens/auth/add_mail.dart';
import 'package:camdell/presentations/screens/auth/auth_services/social%20media%20login/facebook_auth.dart';
import 'package:camdell/presentations/screens/auth/signup_screen.dart';
import 'package:camdell/presentations/screens/auth/signin_screen.dart';
import 'package:camdell/presentations/screens/auth/welcome_screen.dart';
import 'package:camdell/presentations/screens/book%20ride/ride_screen.dart';
import 'package:camdell/presentations/screens/cart/cartpage.dart';
import 'package:camdell/presentations/screens/cart/payment.dart';
import 'package:camdell/presentations/screens/chat/calling_screen.dart';
import 'package:camdell/presentations/screens/home%20page/features/buying%20and%20selling/buying&selling.dart';
import 'package:camdell/presentations/screens/home%20page/features/buying%20and%20selling/detail_page.dart';
import 'package:camdell/presentations/screens/home%20page/features/entertainment/entertainment%20navigation%20bar/navigation_bar.dart';
import 'package:camdell/presentations/screens/home%20page/features/entertainment/entertainment_screen.dart';
import 'package:camdell/presentations/screens/home%20page/features/food_delivery.dart';
import 'package:camdell/presentations/screens/home%20page/features/payment/payment%20navigationbar/payment_navigationbar.dart';
import 'package:camdell/presentations/screens/home%20page/features/payment/payment%20navigationbar/send_trans_page.dart';
import 'package:camdell/presentations/screens/home%20page/features/traveller_screen.dart';
import 'package:camdell/presentations/screens/home%20page/home_screen.dart';
import 'package:camdell/presentations/screens/navigationbar/navigation_page.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/features/elctronic%20delivery/electric_delivery_page.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/features/flower/flower_page.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/features/fruits/banana_page.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/features/supermarket_screen.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/ondemand.dart';
import 'package:camdell/presentations/screens/onboard%20page/onboard_screen.dart';
import 'package:camdell/presentations/screens/ride%20components/ride_summary.dart';
import 'package:camdell/presentations/screens/service%20pages/payment_card_screens.dart';
import 'package:camdell/presentations/screens/setting%20page/features/deactive_account.dart';
import 'package:camdell/presentations/screens/setting%20page/features/delete_account.dart';
import 'package:camdell/presentations/screens/setting%20page/features/edit_profile.dart';
import 'package:camdell/presentations/screens/setting%20page/features/language.dart';
import 'package:camdell/presentations/screens/setting%20page/features/permanent_deactivate.dart';
import 'package:camdell/presentations/screens/setting%20page/features/profile.dart';
import 'package:camdell/presentations/screens/setting%20page/features/security.dart';
import 'package:camdell/presentations/screens/setting%20page/features/setup_profile.dart';
import 'package:camdell/presentations/screens/setting%20page/features/support_page.dart';
import 'package:camdell/presentations/screens/splash%20page/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../presentations/screens/chat/chat_screen.dart';
import '../../presentations/screens/chat/driver_chat_screen.dart';
import '../../presentations/screens/setting page/features/notification.dart';

class Routes {
 static final routes = <GetPage>[
    GetPage(name: AppRoute.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoute.onBoarding, page: () => const OnboardScreen()),
    GetPage(name: AppRoute.welcome, page: () =>  WelcomeScreen(),),
    GetPage(name: AppRoute.signin, page: () => const SignInScreen(),),
    GetPage(name: AppRoute.signup, page: () => const SignupScreen(), ),
    GetPage(name: AppRoute.ride, page: () => const RideScreen()),
    GetPage(name: AppRoute.ondemand, page: () => const OnDemand()),
    GetPage(name: AppRoute.addmail, page: () =>  AddMail(),),
    GetPage(name: AppRoute.home, page: () => const HomeScreen()),
    GetPage(name: AppRoute.navigationbar, page: ()=> const NavigationPage()),
    GetPage(name: AppRoute.setupProfile, page: ()=> const SetUpProfilePage()),
    GetPage(name: AppRoute.profile, page: ()=> const ProfilePage()),
    GetPage(name: AppRoute.deactivate, page: ()=> const DeactivateAccount()),
    GetPage(name: AppRoute.deleteAccount, page: ()=> const PermanentDeactivate()),
    GetPage(name: AppRoute.deleteAccount2, page: ()=> const DeleteAccount()),
    GetPage(name: AppRoute.editProfile, page: ()=> const EditProfilePage()),
    GetPage(name: AppRoute.security, page: ()=> const SecurityPage()),
    GetPage(name: AppRoute.notificationpage, page: () => const NotificationPage()),
    GetPage(name: AppRoute.support, page: ()=> const SupportPage()),
    GetPage(name: AppRoute.language, page: () => const LanguagePage()),
    GetPage(name: AppRoute.ridesummary, page: () => const RideSummary()),
    GetPage(name: AppRoute.chatdriver, page: () => const DriverChatScreen()),
    GetPage(name: AppRoute.cardscreen, page: () => const CardInputPage()),
    GetPage(name: AppRoute.chatScreen, page: () => const ChatScreen()),
    GetPage(name: AppRoute.voicecall, page: () => const CallingScreen()),
    GetPage(name: AppRoute.supermarket, page: () => const SupermarketScreen()),
    GetPage(name: AppRoute.banana, page: ()=> const BananaPage()),
    GetPage(name: AppRoute.cart, page: () => const Cartpage()),
    GetPage(name: AppRoute.payment, page: () => const Payment()),
    GetPage(name: AppRoute.electronic, page: ()=> const ElectronicDeliveryPage()),
    GetPage(name: AppRoute.flower, page: () => const FlowerPage()),
    GetPage(name: AppRoute.foodelivery, page: () => const FoodDelivery()),
    GetPage(name: AppRoute.travel, page: () => const TravelPage()),
    GetPage(name: AppRoute.entertainment, page: ()=> const EntertainmentScreen()),
    GetPage(name: AppRoute.enavigationbar, page: () => const ENavigationBar()),
    GetPage(name: AppRoute.paymentscreen, page: () => const PaymentNavigationbar()),
    GetPage(name: AppRoute.sendtrans, page: () => const SendTransPage()),
    GetPage(name: AppRoute.buyandsell, page: () => const BuyingsellingPage()),
    GetPage(name: AppRoute.shoedetail, page: () => const DetailPage()),
  ];
}