// ignore_for_file: unused_import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shop_app/models/AccountModel.dart';
import 'package:shop_app/models/ErrorModel.dart';
import 'package:shop_app/models/UserModel.dart';
import 'package:shop_app/models/state/AccountState.dart';
import 'package:shop_app/models/state/CartState.dart';
import 'package:shop_app/models/state/FavoriteState.dart';
import 'package:shop_app/models/state/OrderDetailsState.dart';
import 'package:shop_app/models/state/OrderState.dart';
import 'package:shop_app/models/state/ProdactState.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/services/AccountService/login_service.dart';
import 'package:shop_app/services/AccountService/product.service.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../helper/keyboard.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  bool? remember = false;
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final error_state = Provider.of<Errors>(context, listen: false);
    final product_state = Provider.of<ProductState>(context, listen: true);
    final user_state = Provider.of<UserState>(context, listen: false);

    final favorite_state = Provider.of<FavoriteState>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _mail,
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
              if (value!.isEmpty && !error_state.eror.contains(kEmailNullError)) {
                setState(() {
                  error_state.addError(error: kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !error_state.eror.contains(kInvalidEmailError)) {
                setState(() {
                  error_state.addError(error: kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Mail",
              hintText: "Mail girin",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _password,
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                error_state.removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                error_state.removeError(error: kShortPassError);
              }
              return;
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
              hintText: "Şifre girin",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Beni Hatırla"),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  error_state.eror.clear();
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                },
                child: const Text(
                  "Şifrem Unuttum",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: error_state.eror),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final user =
                    AccountModel.withMailandPassword(mail: _mail.text, password: _password.text);
                await ApiContent().login(
                    user.mail.toString(), user.password.toString(), context, error_state.addError);
                //product_state.fetchProducts();// tüm ürünleri getirme methodu
                await product_state.fetchProducts();

                await favorite_state.fetch_favorite(user_state.logicalref);

                //Navigator.pushNamed(context, InitScreen.routeName);
              }
            },
            child: const Text("Giriş Yap"),
          ),
        ],
      ),
    );
  }
}
