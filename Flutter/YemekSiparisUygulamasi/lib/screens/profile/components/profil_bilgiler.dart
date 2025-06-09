import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/appbar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/profile/components/address.dart';
import 'package:shop_app/screens/profile/components/hesab%C4%B1m.dart';
import 'package:shop_app/services/AccountService/login_service.dart';
import 'package:shop_app/models/state/AccountState.dart';

class MyProfile extends StatelessWidget {
  static String routaName = "/myprofile";
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const AppbarDesing(
          space: 0,
          text1: "Kullanıcı Bilgilerim",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            AcilirCard(
              baslik: "Ad",
              deger: userState.name,
              route: MyAddress.routaName,
              onSave: (value) => userState.setName(value),
            ),
            const SizedBox(height: 10),
            AcilirCard(
              baslik: "Soyad",
              deger: userState.surname,
              route: MyAddress.routaName,
              onSave: (value) => userState.setsurname(value),
            ),
            const SizedBox(height: 10),
            AcilirCard(
              baslik: "Mail Adresim",
              deger: userState.email,
              route: Hesabim.routaName,
              onSave: (value) => userState.setEmail(value),
            ),
            const SizedBox(height: 10),
            AcilirCard(
              baslik: "Telefon Numaram",
              deger: userState.telno,
              route: Hesabim.routaName,
              onSave: (value) => userState.setTel(value),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    
    );
  }
}

class AcilirCard extends StatefulWidget {
  final String baslik;
  final String deger;
  final String route;
  final ValueChanged<String> onSave;

  const AcilirCard({
    required this.baslik,
    required this.deger,
    required this.route,
    required this.onSave,
    super.key,
  });

  @override
  _AcilirCardState createState() => _AcilirCardState();
}

class _AcilirCardState extends State<AcilirCard> {
  late TextEditingController controller;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.deger);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ExpansionTile(
        title: Text(widget.baslik),
        leading: const Icon(Icons.info, color: Colors.black),
        trailing: const Icon(Icons.arrow_drop_down, color: Color.fromARGB(255, 0, 0, 0)),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: kPrimaryColor,
        collapsedIconColor: const Color.fromARGB(255, 255, 255, 255),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.deger),
                if (isEditing) ...[
                  const SizedBox(height: 10),
                  Container(
                    height: 45,
                    width: 350,
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          labelText: 'Yeni Değer Girin',
                          border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero)),
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (isEditing) {
                          /* final model = AccountModel(
                              LOGICALREF: userState.logicalref,
                              NAME: userState.name,
                              SURNAME: userState.surname,
                              MAIL: userState.email,
                              PASSWORD: userState.password,
                              TEL: userState.telno);*/

                          userState.updateProfile(context, ApiContent());
                          widget.onSave(controller.text);
                        }
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      icon: Icon(isEditing ? Icons.check : Icons.edit),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
