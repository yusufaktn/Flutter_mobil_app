import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/ErrorModel.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    final error_state = Provider.of<Errors>(context, listen: true);
    return Column(
      children: List.generate(
          error_state.eror.length, (index) => formErrorText(error: error_state.eror[index]!)),
    );
  }

  Row formErrorText({required String error}) {
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
