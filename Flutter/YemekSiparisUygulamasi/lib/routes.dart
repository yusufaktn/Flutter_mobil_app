import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/admin/admin_panel.dart';
import 'package:shop_app/screens/admin/product_add_remove/product_add.dart';
import 'package:shop_app/screens/cart/components/Payment/payment_screen.dart';
import 'package:shop_app/screens/cart/components/AddressCart/addresscart.dart';
import 'package:shop_app/screens/home/components/categories/categories_screenns/AnaYemeklerscreen.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/screens/profile/components/address.dart';
import 'package:shop_app/screens/profile/components/hesab%C4%B1m.dart';
import 'package:shop_app/screens/profile/components/myorders.dart';
import 'package:shop_app/screens/profile/components/profil_bilgiler.dart';

import 'screens/cart/cart_screen.dart';
import 'screens/complete_profile/complete_profile_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/init_screen.dart';
import 'screens/login_success/login_success_screen.dart';
import 'screens/otp/otp_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(
        mail: '',
        password: '',
      ),
  OtpScreen.routeName: (context) => OtpScreen(
        ad: "",
        soyad: "",
        mail: "",
        password: "",
        tel: "",
      ),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProductsScreen.routeName: (context) => const ProductsScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  Hesabim.routaName: (context) => const Hesabim(),
  MyProfile.routaName: (context) => const MyProfile(),
  MyAddress.routaName: (context) => const MyAddress(),
  AdminScreen.routaName: (context) => const AdminScreen(),
  ProductAddScrenn.routaName: (context) => ProductAddScrenn(),
  MyOrders.routaName: (context) => const MyOrders(),
  AnaYemekScreen.routaName: (context) => const AnaYemekScreen(),
  PaymentScreen.routaName: (context) => const PaymentScreen(),
  AddressCart.routaName :(context) =>  const AddressCart()
};
