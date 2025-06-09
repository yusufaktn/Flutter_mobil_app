import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/ErrorModel.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/services/AccountService/login_service.dart';

import '../../constants.dart';
import 'components/otp_form.dart';

class OtpScreen extends StatelessWidget {
  String ad;
  String soyad;
  String mail;
  String password;
  String tel;

  static String routeName = "/otp";

  OtpScreen(
      {required this.ad,
      required this.soyad,
      required this.mail,
      required this.password,
      required this.tel,
      super.key});
  @override
  Widget build(BuildContext context) {
    final error_state = Provider.of<Errors>(context, listen: false);
    //final check_state = Provider.of<Checks>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mail Doğrulama"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Mail Doğrulama",
                  style: headingStyle,
                ),
                const Text("Onay Kodunu Mail hesabınıza gönderdik"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Kodun süresi:"),
                    TweenAnimationBuilder(
                      tween: Tween(begin: 2 * 60, end: 0.0),
                      duration: const Duration(
                        minutes: 2,
                      ),
                      builder: (_, dynamic value, child) {
                        int minutes = (value / 60).floor();
                        int seconds = (value % 60).toInt();
                        return Text("$minutes:${seconds.toString().padLeft(2, '0')}",
                            style: const TextStyle(color: Colors.red, fontSize: 20));
                      },
                      onEnd: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormError(errors: error_state.eror),
                      //Check(checking: check_state.check)
                    ],
                  ),
                ),
                OtpForm(
                  ad: ad,
                  soyad: soyad,
                  mail: mail,
                  password: password,
                  tel: "",
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    ApiContent().sendemail(mail, "Onay Kodunuz", "2v Yazılım");
                  },
                  child: const Text(
                    "Onay Kodunu Tekrar Gönder",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
