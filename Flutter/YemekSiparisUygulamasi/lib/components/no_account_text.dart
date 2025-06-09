import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/ErrorModel.dart';

import '../constants.dart';
import '../screens/sign_up/sign_up_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final error_state = Provider.of<Errors>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Bir Hesabınız Yok Mu ? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            error_state.eror.clear();
            Navigator.pushNamed(context, SignUpScreen.routeName);
          },
          child: const Text(
            "Kayıt Ol",
            style: TextStyle(fontSize: 16, color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
