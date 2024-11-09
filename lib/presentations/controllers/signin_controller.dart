
// import 'package:camdell/presentations/screens/auth/signin_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';

// class SignInController extends GetxController with GetSingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<Offset> slideAnimation;
//   Rx<AuthRoute> authRoute = AuthRoute.none.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     slideAnimation = Tween<Offset>(
//       begin: const Offset(-1.0, 0.0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: animationController,
//       curve: Curves.easeOut,
//     ));

//     ever(authRoute, (_) {
//       if (authRoute.value != AuthRoute.none) {
//         animationController.forward();
//       } else {
//         animationController.reverse();
//       }
//     });
//   }

//   @override
//   void onClose() {
//     animationController.dispose();
//     super.onClose();
//   }
// }