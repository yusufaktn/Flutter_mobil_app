import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/admin/product_add_remove/product_add.dart';
import 'package:shop_app/screens/admin/product_add_remove/product_add_screen.dart';

class AdminScreen extends StatelessWidget {
  static String routaName = "/admin";
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            buildCard(
              context,
              iconPath: "assets/icons/address-svgrepo-com.svg",
              title: "Ürün Ekle",
              onTap: () {
                Navigator.pushNamed(context, ProductAddScrenn.routaName);
                
              },
            ),
            buildCard(
              context,
              iconPath: "assets/icons/address-svgrepo-com.svg",
              title: "Ürün Güncelle",
              onTap: () {},
            ),
            buildCard(
              context,
              iconPath: "assets/icons/address-svgrepo-com.svg",
              title: "Ürün Çıkar",
              onTap: () {},
            )
          ],
        ));
  }
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
