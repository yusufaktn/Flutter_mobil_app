import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({Key? key}) : super(key: key);

  @override
  _DiscountBannerState createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  bool isStar1 = false;
  bool isStar2 = false;
  bool isStar3 = false;
  bool isStar4 = false;
  bool isStar5 = false;

  void reset_star() {
    setState(() {
      isStar1 = false;
      isStar2 = false;
      isStar3 = false;
      isStar4 = false;
      isStar5 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(text: "Günün Yemeği\n"),
                TextSpan(
                  text: "Ezogelin Çorbası",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              stars(context),
            ],
          ),
        ],
      ),
    );
  }

  Padding stars(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: Text("Patlıcan Musakka"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Değerlendirme Yapın"),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                reset_star();
                                isStar1 = !isStar1;
                              });
                            },
                            icon: isStar1
                                ? Icon(Icons.star, color: Colors.amber)
                                : Icon(Icons.star_border),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                reset_star();
                                isStar2 = !isStar2;
                                isStar1 = !isStar1;
                              });
                            },
                            icon: isStar2
                                ? Icon(Icons.star, color: Colors.amber)
                                : Icon(Icons.star_border),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                reset_star();
                                isStar3 = !isStar3;
                                isStar2 = !isStar2;
                                isStar1 = !isStar1;
                              });
                            },
                            icon: isStar3
                                ? Icon(Icons.star, color: Colors.amber)
                                : Icon(Icons.star_border),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                reset_star();
                                isStar4 = !isStar4;
                                isStar3 = !isStar3;
                                isStar2 = !isStar2;
                                isStar1 = !isStar1;
                              });
                            },
                            icon: isStar4
                                ? Icon(Icons.star, color: Colors.amber)
                                : Icon(Icons.star_border),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                reset_star();
                                isStar5 = !isStar5;
                                isStar4 = !isStar4;
                                isStar3 = !isStar3;
                                isStar2 = !isStar2;
                                isStar1 = !isStar1;
                              });
                            },
                            icon: isStar5
                                ? Icon(Icons.star, color: Colors.amber)
                                : Icon(Icons.star_border),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        reset_star();
                        Navigator.of(context).pop();

                        /*showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Değerlendirmeniz İçin\n      Teşekkür Ederiz",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      Colors.amber.shade900),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(Icons.check_circle_outline)
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                );*/
                      },
                      child: Text("Kapat"),
                    ),
                  ],
                );
              });
            },
          );
        },
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: Scaffold(body: DiscountBanner())));
}
