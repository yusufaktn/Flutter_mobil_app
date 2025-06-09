import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/appbar.dart';
import 'package:shop_app/models/ErrorModel.dart';

import '../../components/socal_card.dart';
import '../../constants.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final error_state = Provider.of<Errors>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const AppbarDesing(text1: "Kayıt Ol", space: 0),
        leading: IconButton(
            onPressed: () {
              error_state.cleareror();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Hesap Oluştur", style: headingStyle),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Bilgilerinizi tamamlayın veya  sosyal medya ile devam edin",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const SignUpForm(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Devam Ederek Şart Ve Koşullarımızı Kabul Ettiğinizi Onaylamış Olursunuz.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Image.asset("assets/images/2v-Photoroom.png")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
