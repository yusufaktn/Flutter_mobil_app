import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(25, 133, 180, 100);
const kPrimaryLightColor = Color.fromRGBO(25, 133, 180, 100);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color.fromRGBO(25, 133, 180, 100)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;
const kAnimationDuration = Duration(milliseconds: 200);
const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Lütfen Mail Adresinizi Giriniz";
const String kInvalidEmailError = "Hatalı Mail Adresi Girişi";
const String kPassNullError = "Lütfen Şifrenizi Giriniz";
const String kShortPassError = "Şifre Çok Kısa";
const String kMatchPassError = "Parolalar Eşleşmiyor";
const String kNamelNullError = "Lütfen İsminizi Giriniz";
const String kSurnameNullError = "Lütfen Soyisminizi Giriniz";
const String kPhoneNumberNullError = "Lütfen Telefon Numaranızı Giriniz";
const String kAddressNullError = "Lütfen Adresinizi Giriniz";
const String kUserAccountError = "Kullanıcı Kaydı Bulunamadı";
const String kCodeError = "Kod Yanlış Tekrar Deneyin";

var baseurl = "https://172.19.224.1:7042";
final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kTextColor),
  );
}
