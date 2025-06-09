import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/AddressModel.dart';
import 'package:shop_app/models/state/AccountState.dart';
import 'package:shop_app/services/AddressService/address_service.dart';

class MyAddress extends StatefulWidget {
  static String routaName = "/address";
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  int _selectedindex = -1;
  @override
  Widget build(BuildContext context) {
    TextEditingController il = TextEditingController();
    TextEditingController ilce = TextEditingController();
    TextEditingController mahalle = TextEditingController();
    TextEditingController sokak = TextEditingController();
    TextEditingController bina_no = TextEditingController();
    TextEditingController kat_daire = TextEditingController();

    double height = 30;

    final userState = Provider.of<UserState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          //const Text("Adres Seç:"),
          /*IconButton(
              onPressed: () {
                if (userState.address.length == 0) {
                  return;
                }
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return SingleChildScrollView(
                          child: AlertDialog(
                            title: Text(
                                "${userState.gecicidAddress!.DISTRICT}/${userState.gecicidAddress!.CITY}/B:${userState.gecicidAddress!.BUILD_NO}/K:${userState.gecicidAddress!.FLOOR_FLATNO}"),
                            content: const Text("Bu Adresi Seçmek İstediğinize Emin misiniz?"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Kapat")),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    userState.selectAddress(userState.gecicidAddress!);
                                    _selectedindex =
                                        userState.address.indexOf(userState.selectedAddress!);
                                  },
                                  child: Text("Seç"))
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              icon: Icon(Icons.check)),*/
          const Text("Adres Ekle :"),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: ((context, setState) {
                      return SingleChildScrollView(
                        child: AlertDialog(
                          title: const Text(
                            "Adres Güncelle",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            children: [
                              TextField(
                                decoration: CustomInput("İl"),
                                controller: il,
                              ),
                              SizedBox(
                                height: height,
                              ),
                              TextField(
                                decoration: CustomInput("İlçe"),
                                controller: ilce,
                              ),
                              SizedBox(
                                height: height,
                              ),
                              TextField(
                                decoration: CustomInput("Mahalle"),
                                controller: mahalle,
                              ),
                              SizedBox(
                                height: height,
                              ),
                              TextField(
                                decoration: CustomInput("Sokak"),
                                controller: sokak,
                              ),
                              SizedBox(
                                height: height,
                              ),
                              TextField(
                                decoration: CustomInput("Bina No"),
                                controller: bina_no,
                              ),
                              SizedBox(
                                height: height,
                              ),
                              TextField(
                                decoration: CustomInput("Kat/Daire"),
                                controller: kat_daire,
                              ),
                              SizedBox(
                                height: height,
                              ),
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
                                        onPressed: () async {
                                          var adres = Address(
                                              LOGICALREF: 0,
                                              ACCOUNTREF: userState.logicalref,
                                              CITY: il.text,
                                              TOWN: ilce.text,
                                              DISTRICT: mahalle.text,
                                              FLOOR_FLATNO: kat_daire.text,
                                              STREET: sokak.text,
                                              BUILD_NO: bina_no.text);
                                          Navigator.pop(context);
                                          await AddressContent().PostAddress(adres);

                                          userState.fetch_address();
                                        },
                                        child: const Text(
                                          "Kaydet",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }));
                  },
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Consumer<UserState>(
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: userState.address.length,
                itemBuilder: (context, index) {
                  final address = userState.address[index];

                  return ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: kPrimaryColor,
                    ),
                    title: Text("${address.TOWN}/${address.CITY}"),
                    subtitle: Text(
                        "${address.DISTRICT}/${address.STREET}/B:${address.BUILD_NO}/K:${address.FLOOR_FLATNO}"),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Adresi Sil"),
                                content: const Text("Bu adresi Silmek İstediğinize Emin Misiniz?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Dialogu kapat
                                    },
                                    child: const Text("Hayır"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await AddressContent().DeleteAddress(address.LOGICALREF);
                                      userState.fetch_address();

                                      Navigator.of(context).pop(); // Dialogu kapat
                                    },
                                    child: const Text("Evet"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    selected: _selectedindex == index,
                    onTap: () {
                      setState(() {
                        userState.addressTemp(address);
                        _selectedindex = userState.address.indexOf(userState.gecicidAddress!);
                      });
                    },
                    selectedColor: Colors.red,
                    selectedTileColor: Color.fromARGB(255, 239, 238, 236),
                  );
                },
              );
            },
          )),
        ],
      ),
      /*bottomNavigationBar: Container(
        height: 80,
        color: kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.join_right)),
            const SizedBox(
              width: 30,
            )
          ],
        ),
      ),*/
    );
  }
}

InputDecoration CustomInput(String hintext) {
  return InputDecoration(
      labelText: hintext,
      hintText: hintext,
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)));
}
