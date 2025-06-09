import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/ErrorModel.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../complete_profile/complete_profile_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;
  bool remember = false;
  TextEditingController mail = TextEditingController();
  TextEditingController sifre1 = TextEditingController();
  TextEditingController sifre2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final error_state = Provider.of<Errors>(context, listen: true);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: mail,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                error_state.removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                error_state.removeError(error: kInvalidEmailError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                error_state.addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                error_state.addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Mail",
              hintText: "Mail Girin",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: sifre1,
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                error_state.removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                error_state.removeError(error: kShortPassError);
              }
              password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                error_state.addError(error: kPassNullError);
                return "";
              } else if (value.length < 8) {
                error_state.addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Şifre",
              hintText: "Şifrenizi girin",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: sifre2,
            obscureText: true,
            onSaved: (newValue) => conform_password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                error_state.removeError(error: kPassNullError);
              } else if (value.isNotEmpty && password == conform_password) {
                error_state.removeError(error: kMatchPassError);
              }
              conform_password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                error_state.addError(error: kPassNullError);
                return "";
              } else if ((password != value)) {
                error_state.addError(error: kMatchPassError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Şifreyi Onayla",
              hintText: "Şifrenizi Yeniden Girin",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          FormError(errors: error_state.eror),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                error_state.eror.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CompleteProfileScreen(mail: mail.text, password: sifre1.text),
                    ));

                //final user = AccountModel.withMailandPassword(MAIL: mail.text, PASSWORD: sifre1.text);
                //ApiContent().register(mail.toString(), sifre1.toString(), sifre2.toString(), context);
              }
            },
            child: const Text("Devam Et"),
          ),
        ],
      ),
    );
  }
}
