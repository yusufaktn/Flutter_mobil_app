// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/appbar.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/state/AccountState.dart';
import 'package:shop_app/models/state/CartState.dart';
import 'package:shop_app/models/state/OrderDetailsState.dart';
import 'package:shop_app/models/state/OrderState.dart';
import 'package:shop_app/models/state/ProdactState.dart';
import 'package:shop_app/screens/admin/admin_panel.dart';
import 'package:shop_app/screens/profile/components/address.dart';
import 'package:shop_app/screens/profile/components/myorders.dart';
import 'package:shop_app/screens/profile/components/profil_bilgiler.dart';
import 'package:shop_app/services/AccountService/product.service.dart';
import 'package:shop_app/services/AddressService/address_service.dart';

class Hesabim extends StatefulWidget {
  static String routaName = "/hesabim";
  const Hesabim({super.key});

  @override
  State<Hesabim> createState() => _HesabimState();
}

class _HesabimState extends State<Hesabim> {
  TextEditingController mail = TextEditingController();
  TextEditingController mail2 = TextEditingController();
  TextEditingController il = TextEditingController();
  TextEditingController ilce = TextEditingController();
  TextEditingController mahalle = TextEditingController();
  TextEditingController acik_adres = TextEditingController();

  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context, listen: true);
    final product_State = Provider.of<ProductState>(context, listen: true);
    final order_state = Provider.of<OrderState>(context, listen: true);
    final orderDetail_state = Provider.of<OrderDetailState>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
          title: const AppbarDesing(
        text1: "Hesabım",
        space: 0,
      )),
      body: ListView(
        children: [
          buildProfileCard(context),
          /*  buildCard(
            context,
            iconPath: "assets/icons/Mail.svg",
            title: "İletişim Bilgileri",
            onTap: () {
              Navigator.pushNamed(context, MailPage.routaName);
              /* showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: ((context, setState) {
                    return AlertDialog(
                        title: const Text("Mail Güncelle"),
                        content: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (newValue) => email = newValue,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  removeError(error: kEmailNullError);
                                } else if (emailValidatorRegExp.hasMatch(value)) {
                                  removeError(error: kInvalidEmailError);
                                }
                                return;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  addError(error: kEmailNullError);
                                  return "";
                                } else if (!emailValidatorRegExp.hasMatch(value)) {
                                  addError(error: kInvalidEmailError);
                                  return "";
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
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (newValue) => email = newValue,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  removeError(error: kEmailNullError);
                                } else if (emailValidatorRegExp.hasMatch(value)) {
                                  removeError(error: kInvalidEmailError);
                                }
                                return;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  addError(error: kEmailNullError);
                                  return "";
                                } else if (!emailValidatorRegExp.hasMatch(value)) {
                                  addError(error: kInvalidEmailError);
                                  return "";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: "Yeni Mail",
                                hintText: "Yeni Mailinizi girin",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FormError(errors: errors),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(0))),
                                      onPressed: () {
                                        mail.clear();
                                        mail2.clear();
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Kapat",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(0))),
                                      onPressed: () {
                                        if (mail.text == userState.email) {
                                          userState.setEmail(mail2.text);
                                          mail.clear();
                                          mail2.clear();
                                        }

                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Kaydet",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                )
                              ],
                            )
                          ],
                        ));
                  }));
                },
              );*/
            },
          ),*/
          buildCard(
            context,
            iconPath: "assets/icons/address-svgrepo-com.svg",
            title: "Adres Bilgilerim",
            onTap: () {
              Navigator.pushNamed(context, MyAddress.routaName);
              userState.fetch_address();
            },
          ),
          /*buildCard(
            context,
            iconPath: "assets/icons/address-svgrepo-com.svg",
            title: "veri tabanı ürün çekme deneme",
            onTap: () {
              product_State.fetchProducts();
            },
          ),*/
          buildCard(
            context,
            iconPath: "assets/icons/address-svgrepo-com.svg",
            title: "ADMIN PANEL",
            onTap: () {
              Navigator.pushNamed(context, AdminScreen.routaName);
            },
          ),
          buildCard(
            context,
            iconPath: "assets/icons/address-svgrepo-com.svg",
            title: "Siparişlerim",
            onTap: () async {
              int sayi = userState.logicalref.toInt();
              await product_State.fetch_customerprofile(sayi);
              await order_state.fetch_order(sayi);
              await orderDetail_state.fetch_orderdetails(sayi);
              Navigator.pushNamed(context, MyOrders.routaName);
            },
          ),
        ],
      ),
    );
  }

  InputDecoration CustomInput(String hintext) {
    return InputDecoration(
        labelText: hintext,
        hintText: hintext,
        enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
        focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)));
  }

  Widget buildProfileCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Color(0xFFF5F6F9),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage("assets/images/Profile Image.png"),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  "Kullanıcı Bilgilerim",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kPrimaryColor),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyProfile.routaName);
                },
                icon: const Icon(Icons.edit, color: kPrimaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
    BuildContext context, {
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Color(0xFFF5F6F9),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgPicture.asset(iconPath, height: 20, color: kPrimaryColor),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, color: kPrimaryColor),
                ),
              ),
              IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.arrow_forward_ios, color: kPrimaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
