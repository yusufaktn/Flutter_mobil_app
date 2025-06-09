import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/appbar.dart';
import 'package:shop_app/models/ErrorModel.dart';

import '../../constants.dart';
import 'components/complete_profile_form.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  final String mail;
  final String password;

  const CompleteProfileScreen({required this.mail, required this.password, super.key});
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
                  const Text(
                    "Bilgilerinizi tamamlayın veya\n sosyal medya ile devam edin",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CompleteProfileForm(
                    mail: mail,
                    password: password,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Devam ederek Şart ve Koşullarımızı kabul ettiğinizi onaylıyorsunuz.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
