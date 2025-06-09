import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/state/AccountState.dart';
import 'package:shop_app/screens/cart/components/AddressCart/addressCheckOut.dart';

class AddressCart extends StatefulWidget {
  static String routaName = "/addresscart";
  const AddressCart({super.key});

  @override
  State<AddressCart> createState() => _AddressCartState();
}

class _AddressCartState extends State<AddressCart> {
  int _selectedindex = -1;

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Adres Seç"),
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
                    selected: _selectedindex == index,
                    onTap: () {
                      setState(() {
                        userState.selectAddress(address);
                        _selectedindex = userState.address.indexOf(userState.selectedAddress!);
                      });
                    },
                    selectedColor: Colors.red,
                    selectedTileColor: Color.fromARGB(255, 244, 242, 239),
                  );
                },
              );
            },
          )),
        ],
      ),
      bottomNavigationBar: const AddressCheck(),
    );
  }
}
