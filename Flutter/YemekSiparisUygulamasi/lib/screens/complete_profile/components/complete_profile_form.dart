import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/ErrorModel.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/services/AccountService/login_service.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';

class CompleteProfileForm extends StatefulWidget {
  final String mail;
  final String password;

  const CompleteProfileForm({required this.mail, required this.password, super.key});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  TextEditingController ad = TextEditingController();
  TextEditingController soyad = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final error_state = Provider.of<Errors>(context, listen: true);

    // TextEditingController tel = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: ad,
            onSaved: (newValue) => firstName = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                error_state.removeError(error: kNamelNullError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                error_state.addError(error: kNamelNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Ad",
              hintText: "Adınızı Girin",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: soyad,
            onSaved: (newValue) => lastName = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                error_state.removeError(error: kSurnameNullError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                error_state.addError(error: kSurnameNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Soyad",
              hintText: "Soyadınızı girin",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),
          /* TextFormField(
            controller: tel,
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phoneNumber = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPhoneNumberNullError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPhoneNumberNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Telefon Numarası",
              hintText: "Telefon Numarasını Girin",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            ),
          ),*/
          const SizedBox(height: 20),
          FormError(errors: error_state.eror),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                //Navigator.pushNamed(context, HomeScreen.routeName);
                /*final model = AccountModel(
                    LOGICALREF: 0,
                    NAME: ad.text,
                    SURNAME: soyad.text,
                    MAIL: widget.mail,
                    PASSWORD: widget.password,
                    TEL: "");*/
                setState(() {
                  ApiContent().sendemail(widget.mail, "Onay Kodunuz", "2v Yazılım");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpScreen(
                              ad: ad.text,
                              soyad: soyad.text,
                              mail: widget.mail,
                              password: widget.password,
                              tel: "")));
                  error_state.eror.clear();
                  //ApiContent().register(model, context, error_state.addError);
                });
              }
            },
            child: const Text("Devam Et"),
          ),
        ],
      ),
    );
  }
}
