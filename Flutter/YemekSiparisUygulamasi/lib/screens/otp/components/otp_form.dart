import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/AccountModel.dart';
import 'package:shop_app/models/ErrorModel.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/services/AccountService/login_service.dart';

import '../../../constants.dart';

class OtpForm extends StatefulWidget {
  String ad;
  String soyad;
  String mail;
  String password;
  String tel;

  OtpForm({
    required this.ad,
    required this.soyad,
    required this.mail,
    required this.password,
    required this.tel,
    Key? key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController s1 = TextEditingController();
    TextEditingController s2 = TextEditingController();
    TextEditingController s3 = TextEditingController();
    TextEditingController s4 = TextEditingController();

    return Form(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: s1,
                  autofocus: true,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: s2,
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: s3,
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: s4,
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FocusNode!.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          ElevatedButton(
            onPressed: () async {
              final error_state = Provider.of<Errors>(context, listen: false);
              String sayi = s1.text + s2.text + s3.text + s4.text;
              if (ApiContent.code == null) {
                print("boş değer");
              }

              if (ApiContent.code == sayi) {
                print("Kod Girişi Başarılı");
                final model = AccountModel(
                    logicalref: 0,
                    name: widget.ad,
                    surname: widget.soyad,
                    mail: widget.mail,
                    password: widget.password,
                    tel: "");
                ApiContent().register(model, context, error_state.addError);
                Navigator.pushNamed(context, InitScreen.routeName);
              } else {
                print("Giriş Yapılamadı Kod Yanlış");
                error_state.addError(error: kCodeError);
              }
            },
            child: const Text("Devam Et"),
          ),
        ],
      ),
    );
  }
}
