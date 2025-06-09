import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/CheckModel.dart';

class Check extends StatelessWidget {
  const Check({
    Key? key,
    required this.checking,
  }) : super(key: key);

  final List<String?> checking;

  @override
  Widget build(BuildContext context) {
    final check_state = Provider.of<Checks>(context, listen: true);
    return Column(
      children: List.generate(
          check_state.check.length, (index) => formcheckText(error: check_state.check[index]!)),
    );
  }

  Row formcheckText({required String error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: 16,
          width: 16,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(error),
      ],
    );
  }
}
