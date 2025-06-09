import 'package:flutter/material.dart';

@override
class ProductAddScrenn extends StatefulWidget {
  static String routaName = "/addproduct";
  ProductAddScrenn({super.key});

  @override
  State<ProductAddScrenn> createState() => _ProductAddScrennState();
}

class _ProductAddScrennState extends State<ProductAddScrenn> {
  final List<String> _hinttext = [
    "Ürün adı",
    "Ürün Kodu",
    "Açıklama",
    "Ürün Fiyat",
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            height: 200,
            alignment: Alignment.topCenter,
            color: const Color.fromARGB(255, 203, 202, 197),
            child: const Center(child: Text("+ Ürün Ekle")),
          ),
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                height: screenHeight,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  children: List.generate(
                      4,
                      (index) => TextFormField(
                            decoration: InputDecoration(
                                labelText: _hinttext[index],
                                hintText: _hinttext[index],
                                border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
                                focusedBorder:
                                    const OutlineInputBorder(borderRadius: BorderRadius.zero),
                                enabledBorder:
                                    const OutlineInputBorder(borderRadius: BorderRadius.zero)),
                          )
                          
                          ),
                ),
              ))
        ],
      ),
    );
  }
}
