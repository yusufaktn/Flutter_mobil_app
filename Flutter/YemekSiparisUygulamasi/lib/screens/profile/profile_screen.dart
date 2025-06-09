// ignore_for_file: duplicate_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/appbar.dart';
import 'package:shop_app/models/ErrorModel.dart';
import 'package:shop_app/screens/profile/components/hesab%C4%B1m.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import 'components/hesabım.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final error_state = Provider.of<Errors>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const AppbarDesing(
          text1: "Profil",
          space: 20,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Hesabım",
              icon: "assets/icons/User Icon.svg",
              press: () => {Navigator.pushNamed(context, Hesabim.routaName)},
            ),
            /*ProfileMenu(
              text: "Bildirimler",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),*/
            /*ProfileMenu(
              text: "Ayarlar",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),*/
            /*ProfileMenu(
              text: "Yardım Merkezi",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),*/
            ProfileMenu(
              text: "Çıkış Yap",
              icon: "assets/icons/Log out.svg",
              press: () {
                error_state.eror.clear();
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
