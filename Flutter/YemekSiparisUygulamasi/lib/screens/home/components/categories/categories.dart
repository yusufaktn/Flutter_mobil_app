import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/home/components/categories/categories_screenns/AnaYemeklerscreen.dart';
import 'package:shop_app/screens/home/components/categories/categories_screenns/CorbalarScreen.dart';
import 'package:shop_app/screens/home/components/categories/categories_screenns/SicakIceceklerScreen.dart';
import 'package:shop_app/screens/home/components/categories/categories_screenns/SogukIceceklerScreen.dart';
import 'package:shop_app/screens/home/components/categories/categories_screenns/Tatl%C4%B1larScreen.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/meal-svgrepo-com.svg",
        "text": "Ana Yemekler",
        "page": AnaYemekScreen()
      },
      {
        "icon": "assets/icons/soup-plate-svgrepo-com.svg",
        "text": "Çorbalar",
        "page": CorbalarScreen()
      },
      {
        "icon": "assets/icons/ice-drink-svgrepo-com.svg",
        "text": "Soğuk İçecekler",
        "page": SogukIceceklerScreen()
      },
      {
        "icon": "assets/icons/hot-drink-coffee-svgrepo-com.svg",
        "text": "Sıcak İçecekler",
        "page": SicakIceceklerScreen()
      },
      {
        "icon": "assets/icons/sweet-cake-piece-svgrepo-com.svg",
        "text": "Tatlılar",
        "page": TatlilarScreen()
      },
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categories.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => categories[index]["page"],
                      ));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
